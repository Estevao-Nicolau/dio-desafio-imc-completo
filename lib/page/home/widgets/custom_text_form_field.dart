import 'package:flutter/material.dart';

typedef FormValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormValidator? validator;
  final IconData? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
    );
  }
}
