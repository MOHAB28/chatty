import 'package:chatty/core/components/loader.dart';
import 'package:chatty/core/extensions/context.dart';
import 'package:chatty/core/extensions/string.dart';
import 'package:chatty/core/services/auth_service/auth_service.dart';
import 'package:chatty/routes/app_router.dart';
import 'package:chatty/views/auth/view_models/auth_view_model.dart';
import 'package:chatty/views/widgets/button_widget.dart';
import 'package:chatty/views/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(authViewModel);
    final isLoginView = ref.watch(toggleProivder);
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
              AppRoutesName.homeView,
              (route) => false,
            );
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: viewModel.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isLoginView ? 'Login' : 'Register',
                style: context.textTheme.headlineLarge,
              ),
              const SizedBox(height: 30.0),
              if (!isLoginView) ...[
                TextFormFieldWidget(
                  controller: viewModel.nameController,
                  label: 'Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
              ],
              TextFormFieldWidget(
                controller: viewModel.emailComtroller,
                label: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email!';
                  } else if (!value.isEmail) {
                    return 'Please enter valid email!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormFieldWidget(
                controller: viewModel.passComtroller,
                label: 'Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password!';
                  } else if (value.length < 5) {
                    return 'Password should be at least 6 charcters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              ButtonWidget(
                title: isLoginView ? 'Login' : 'Register',
                onTap: () async {
                  if (viewModel.formKey.currentState!.validate()) {
                    if (isLoginView) {
                      await ref
                          .read(
                            authAction.notifier,
                          )
                          .login(
                            SignInData(
                              email: viewModel.emailComtroller.text,
                              password: viewModel.passComtroller.text,
                            ),
                          );
                    } else {
                      await ref
                          .read(
                            authAction.notifier,
                          )
                          .register(
                            RegisterData(
                              name: viewModel.nameController.text,
                              email: viewModel.emailComtroller.text,
                              password: viewModel.passComtroller.text,
                            ),
                          );
                    }
                  }
                },
              ),
              const SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  ref.read(toggleProivder.notifier).changeStatus();
                },
                child: RichText(
                  text: TextSpan(
                    text: isLoginView
                        ? 'Don\'t have an account yet?'
                        : 'Already have an account?',
                    style: context.textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: isLoginView ? ' Register here' : ' Login here',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
