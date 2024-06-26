import 'dart:async';

import 'package:chatty/core/services/auth_service/auth_service.dart';
import 'package:chatty/core/services/auth_service/auth_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthViewModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailComtroller = TextEditingController();
  final TextEditingController passComtroller = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void dispose() {
    emailComtroller.dispose();
    passComtroller.dispose();
    nameController.dispose();
  }
}

class ToggleProvider extends AutoDisposeNotifier<bool> {
  @override
  bool build() => true;

  void changeStatus() {
    state = !state;
  }
}

class AuthAction extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr build() {}

  Future<void> login(SignInData signInData) async {
    await _performAuthAction(
      () => ref.read(authServiceProvider).signInWithEmailPassword(signInData),
    );
  }

  Future<void> register(RegisterData registerData) async {
    await _performAuthAction(
      () =>
          ref.read(authServiceProvider).registerWithEmailPassword(registerData),
    );
  }

  Future<void> _performAuthAction(Future<void> Function() authAction) async {
    state = const AsyncValue.loading();
    try {
      await authAction();
      state = const AsyncValue.data(null);
    } on FirebaseException catch (e) {
      state = AsyncValue.error(e.message!, StackTrace.empty);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}

final authViewModel = Provider.autoDispose<AuthViewModel>(
  (ref) {
    final AuthViewModel viewModel = AuthViewModel();
    ref.onDispose(() {
      viewModel.dispose();
    });
    return viewModel;
  },
);

final toggleProivder = NotifierProvider.autoDispose<ToggleProvider, bool>(
  ToggleProvider.new,
);

final authAction =
    AsyncNotifierProvider.autoDispose<AuthAction, void>(AuthAction.new);
