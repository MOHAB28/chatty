import 'package:chatty/core/extensions/context.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  const TextFormFieldWidget({
    super.key,
    this.label,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.grey),
    );
    return TextFormField(
      validator: validator,
      controller: controller,
      style: context.textTheme.bodyMedium,
      decoration: InputDecoration(
        label: label != null
            ? Text(
                label!,
                style: context.textTheme.bodyMedium,
              )
            : null,
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
      ),
    );
  }
}
