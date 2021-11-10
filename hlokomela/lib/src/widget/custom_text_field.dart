import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.border,
    this.isPassword,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool? isPassword;
  final OutlineInputBorder? border;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword ?? false,
      controller: controller,
      decoration: InputDecoration(
          border: border ?? const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText
      ),
    );
  }
}