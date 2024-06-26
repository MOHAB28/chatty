import 'package:chatty/core/services/auth_service/auth_service_impl.dart';
import 'package:chatty/core/services/database_service/database_service.dart';
import 'package:chatty/core/services/database_service/database_services_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatViewModel {
  final TextEditingController messageController = TextEditingController();

  void dispose() {
    messageController.dispose();
  }
}

final chatViewModel = Provider.autoDispose<ChatViewModel>((ref) {
  final ChatViewModel viewModel = ChatViewModel();
  ref.onDispose(() {
    viewModel.dispose();
  });
  return viewModel;
});

final messageStream = StreamProvider.autoDispose
    .family<List<Map<String, dynamic>>, String>(
  (ref, arg) => ref.read(databaseServiceProvider).getMessages(
        GetMessageData(
          senderId: ref.watch(authServiceProvider).authStateChanges!.uid,
          receiverId: arg,
        ),
      ),
);
