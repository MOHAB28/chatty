import 'package:chatty/core/services/auth_service/auth_service_impl.dart';
import 'package:chatty/core/services/database_service/database_service.dart';
import 'package:chatty/domain/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseServiceProvider = Provider.autoDispose<DatabaseService>(
  (ref) => DatabaseServiceImpl(
    ref.watch(firebaseFirestoreInstance),
    ref.watch(authServiceProvider).authStateChanges!.uid,
  ),
);

class DatabaseServiceImpl extends DatabaseService {
  final FirebaseFirestore _firestore;
  final String _uid;
  DatabaseServiceImpl(this._firestore, this._uid);

  @override
  Stream<List<Map<String, dynamic>>> getMessages(
    GetMessageData getMessageData,
  ) {
    return _firestore
        .collection('messages')
        .where('senderId', isEqualTo: getMessageData.senderId)
        .where('receiverId', isEqualTo: getMessageData.receiverId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return _firestore.collection('users').snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => UserModel.fromMap(doc.data()))
            .where((user) => user.uid != _uid)
            .toList();
      },
    );
  }

  @override
  Future<void> sendMessage(SendMessageData sendMessageData) async {
    await _firestore.collection('messages').add({
      'text': sendMessageData.text,
      'senderId': sendMessageData.senderId,
      'receiverId': sendMessageData.receiverId,
      'timestamp': Timestamp.now(),
    });
  }
}
