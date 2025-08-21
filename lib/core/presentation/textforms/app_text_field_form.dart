import 'package:flutter/material.dart';

class AppTextFieldForm extends StatelessWidget {
  const AppTextFieldForm({super.key, required this.labelText,this.onChanged, this.keyboardType, this.errorText, this.validator, this.onSaved,});

  final String labelText;
  final String? errorText;
  final void Function(String?)? onSaved;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        onChanged: onChanged,
        onSaved: onSaved,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF4F4F4),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          labelText: labelText,
          errorText: errorText,
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 18),
      ),
    );

  }
}

