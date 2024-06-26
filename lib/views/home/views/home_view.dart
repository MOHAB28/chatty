import 'package:chatty/core/components/loader.dart';
import 'package:chatty/core/extensions/context.dart';
import 'package:chatty/domain/models/user/user_model.dart';
import 'package:chatty/routes/app_router.dart';
import 'package:chatty/views/auth/view_models/auth_view_model.dart';
import 'package:chatty/views/home/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          Consumer(
            builder: (_, ref, __) {
              ref.listen<AsyncValue<void>>(
                authAction,
                (_, next) {
                  next.when(
                    loading: () {
                      Loader.showL(context);
                    },
                    error: (error, _) {
                      Loader.hideL(context);
                      context.showErrorSnackBar(error.toString());
                    },
                    data: (_) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutesName.authView,
                        (route) => false,
                      );
                    },
                  );
                },
              );
              return IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await ref.read(authAction.notifier).logout();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (_, ref, __) {
          final users = ref.watch(getUsers);
          return users.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: $err',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (allUsers) {
              if (allUsers.isEmpty) {
                return Center(
                  child: Text(
                    'No users to show!',
                    style: context.textTheme.headlineSmall,
                  ),
                );
              }
              return ListView.separated(
                itemCount: allUsers.length,
                separatorBuilder: (_, __) => const SizedBox(),
                itemBuilder: (context, index) {
                  UserModel currentUser = allUsers[index];
                  return ListTile(
                    title: Text(currentUser.name),
                    subtitle: Text(currentUser.email),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutesName.chatView,
                        arguments: {
                          'userId': currentUser.uid,
                          'userName': currentUser.name,
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
