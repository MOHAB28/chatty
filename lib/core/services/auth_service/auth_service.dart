import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Stream<User?> get user;
  Future<User?> signInWithEmailPassword(SignInData signInData);
  Future<User?> registerWithEmailPassword(RegisterData registerData);
  Future<void> signOut();
}

class SignInData {
  final String email;
  final String password;

  const SignInData({
    required this.email,
    required this.password,
  });
}

class RegisterData {
  final String name;
  final String email;
  final String password;

  const RegisterData({
    required this.name,
    required this.email,
    required this.password,
  });
}
