import 'package:chatty/core/services/database_service/database_service.dart';
import 'package:chatty/domain/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServiceImpl extends DatabaseService {
  final FirebaseFirestore _firestore;

  DatabaseServiceImpl(this._firestore);
  @override
  Stream<List<Map<String, dynamic>>> getMessages(
    String senderId,
    String receiverId,
  ) {
    return _firestore
        .collection('messages')
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }

  @override
  Future<void> sendMessage(
    String senderId,
    String receiverId,
    String text,
  ) async {
    await _firestore.collection('messages').add({
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': Timestamp.now(),
    });
  }
}
