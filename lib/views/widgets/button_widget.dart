import 'package:chatty/core/extensions/context.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;
  final Color color;

  const ButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 60.0,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Text(
            title,
            style: context.textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
