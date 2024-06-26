// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element
import 'package:chatty/core/extensions/context.dart';
import 'package:chatty/core/services/auth_service/auth_service_impl.dart';
import 'package:chatty/core/services/database_service/database_service.dart';
import 'package:chatty/core/services/database_service/database_services_impl.dart';
import 'package:chatty/views/chat/view_models/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatView extends StatelessWidget {
  final String userId;
  final String userName;
  const ChatView({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final messages = ref.watch(messageStream(userId));
                return messages.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: $err',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  data: (allMessages) {
                    if (allMessages.isEmpty) {
                      return Center(
                        child: Text(
                          'No messages yet!',
                          style: context.textTheme.headlineSmall,
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(20.0),
                      itemCount: allMessages.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                      itemBuilder: (context, index) {
                        bool isMe = allMessages[index]['senderId'] ==
                            ref
                                .watch(authServiceProvider)
                                .authStateChanges!
                                .uid;
                        return _ChatBubble(
                          text: allMessages[index]['text'],
                          isMe: isMe,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Consumer(
            builder: (_, ref, __) {
              final viewModel = ref.watch(chatViewModel);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: viewModel.messageController,
                        decoration:
                            const InputDecoration(labelText: 'Enter message'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        ref.watch(databaseServiceProvider).sendMessage(
                              SendMessageData(
                                senderId: ref
                                    .watch(authServiceProvider)
                                    .authStateChanges!
                                    .uid,
                                receiverId: userId,
                                text: viewModel.messageController.text,
                              ),
                            );

                        viewModel.messageController.clear();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  const _ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
