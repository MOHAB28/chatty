import 'package:chatty/core/services/auth_service/auth_service_impl.dart';
import 'package:chatty/views/auth/views/auth_view.dart';
import 'package:chatty/views/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartupView extends ConsumerWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authServiceProvider).authStateChanges != null 
    ? const HomeView()
    : const AuthView();
  }
}
