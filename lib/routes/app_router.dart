import 'package:chatty/views/auth/views/auth_view.dart';
import 'package:chatty/views/chat/views/chat_view.dart';
import 'package:chatty/views/home/views/home_view.dart';
import 'package:chatty/views/startup/startup_view.dart';
import 'package:flutter/material.dart';

class AppRoutesName {
  static const String startupView = '/Startup-view';
  static const String homeView = '/Home-view';
  static const String authView = '/Authentication-view';
  static const String chatView = '/Chat-view';
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) => switch (settings.name) {
        '/' || AppRoutesName.startupView => MaterialPageRoute(
            builder: (_) => const StartupView(),
          ),
        AppRoutesName.chatView => MaterialPageRoute(
            builder: (_) => const ChatView(),
          ),
        AppRoutesName.authView => MaterialPageRoute(
            builder: (_) => const AuthView(),
          ),
        AppRoutesName.homeView => MaterialPageRoute(
            builder: (_) => const HomeView(),
          ),
        _ => null,
      };
}
