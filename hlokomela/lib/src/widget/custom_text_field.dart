import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.border,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final OutlineInputBorder? border;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
          border: border ?? const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText
      ),
    );
  }
}