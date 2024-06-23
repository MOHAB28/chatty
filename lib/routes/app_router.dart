import 'package:flutter/material.dart';

class AppRoutesName {

}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) => switch (settings.name) {
        // '/' => MaterialPageRoute(
        //     builder: (_) => const StartUpView(),
        //   ),
        _ => null,
      };
}
