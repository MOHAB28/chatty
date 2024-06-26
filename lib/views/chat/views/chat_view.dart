import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
        child: Text('Chat View'),
      ),
    );
  }
}
