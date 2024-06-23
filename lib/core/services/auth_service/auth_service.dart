import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Stream<User?> get user;
  Future<User?> signInWithEmailPassword(String email, String password);
  Future<User?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  );
  Future<void> signOut();
}
