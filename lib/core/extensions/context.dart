import 'package:chatty/core/enums/global_enums.dart';
import 'package:flutter/material.dart';

void _showSnackbar(
  String message,
  ResultState state,
  BuildContext context,
) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: state.color,
    ),
  );
}

extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void showSuccessSnackBar(String message) => _showSnackbar(
        message,
        ResultState.success,
        this,
      );
  void showErrorSnackBar(String message) => _showSnackbar(
        message,
        ResultState.error,
        this,
      );
}
