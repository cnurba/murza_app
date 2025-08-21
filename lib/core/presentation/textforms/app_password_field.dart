import 'package:flutter/material.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({super.key, this.onChanged, required this.hintText, this.errorText, this.prefixIcon});

  final ValueChanged<String>? onChanged;
  final String hintText;
  final String? errorText;
  final IconData? prefixIcon;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF4F4F4),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          hintText: widget.hintText,
          errorText: widget.errorText,
          prefixIcon: Icon(widget.prefixIcon),
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                  _obscureText = !_obscureText;
                });
            },
            child:
            _obscureText
              ? const Icon(
                Icons.visibility_off,
                color: Color(0xFF868686),
              )
              : const Icon(
                Icons.visibility,
                color: Color(0xFF868686),
              ),
          ),

        ),
        style: const TextStyle(fontSize: 16),
      ),
    );

  }
}
