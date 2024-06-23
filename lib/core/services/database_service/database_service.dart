import 'package:chatty/domain/models/user/user_model.dart';

abstract class DatabaseService {
  Stream<List<UserModel>> getUsers();
  Future<void> sendMessage(SendMessageData sendMessageData);
  Stream<List<Map<String, dynamic>>> getMessages(GetMessageData getMessageData);
}

class SendMessageData {
  final String senderId;
  final String receiverId;
  final String text;

  const SendMessageData({
    required this.senderId,
    required this.receiverId,
    required this.text,
  });
}

class GetMessageData {
  final String senderId;
  final String receiverId;

  const GetMessageData({
    required this.senderId,
    required this.receiverId,
  });
}
