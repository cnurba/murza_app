import 'package:flutter/material.dart';

class AppUnderlineTextField extends StatelessWidget {
  const AppUnderlineTextField({super.key, required this.hintText,this.prefixIcon, this.onChanged, this.keyboardType, this.errorText, this.validator,});

  final String hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF4F4F4),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          hintText: hintText,
          errorText: errorText,
          prefixIcon: Icon(prefixIcon),
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );

  }
}

