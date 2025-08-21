import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    this.onSaved,
  });

  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF4F4F4),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Введите email';
          final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
          if (!emailRegex.hasMatch(value)) return 'Некорректный email';
          return null;
        },
        onSaved: onSaved,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}