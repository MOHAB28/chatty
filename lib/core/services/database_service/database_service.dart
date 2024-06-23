import 'package:chatty/domain/models/user/user_model.dart';

abstract class DatabaseService {
  Stream<List<UserModel>> getUsers();
  Future<void> sendMessage(String senderId, String receiverId, String text);
  Stream<List<Map<String, dynamic>>> getMessages(
    String senderId,
    String receiverId,
  );
}
