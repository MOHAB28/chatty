import 'package:flutter/material.dart';

enum ResultState {
  success(Colors.green),
  error(Colors.red);

  final Color color;

  const ResultState(this.color);
}
