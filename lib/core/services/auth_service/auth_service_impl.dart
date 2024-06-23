import 'package:chatty/core/services/auth_service/auth_service.dart';
import 'package:chatty/domain/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthInstance =
    Provider.autoDispose<FirebaseAuth>((_) => FirebaseAuth.instance);

final firebaseFirestoreInstance =
    Provider.autoDispose<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final authServiceProvider = Provider.autoDispose<AuthService>(
  (ref) => AuthServiceImpl(
    ref.watch(firebaseAuthInstance),
    ref.watch(firebaseFirestoreInstance),
  ),
);

class AuthServiceImpl extends AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthServiceImpl(this._auth, this._firestore);

  @override
  Future<User?> registerWithEmailPassword(RegisterData registerData) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: registerData.email,
        password: registerData.password,
      );
      User? user = result.user;

      if (user != null) {
        UserModel newUser = UserModel(
          uid: user.uid,
          name: registerData.name,
          email: registerData.email,
        );
        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithEmailPassword(SignInData signInData) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: signInData.email,
        password: signInData.password,
      );
      return result.user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<User?> get user => _auth.authStateChanges();
}
