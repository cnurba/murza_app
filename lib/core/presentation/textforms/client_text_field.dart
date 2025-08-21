import 'package:flutter/material.dart';

class ClientTextField extends StatelessWidget {
  const ClientTextField({super.key, this.controller, required this.labelText, this.suffixIcon, this.isVisible =true, this.isEnabled = true, this.onChanged});

  final TextEditingController? controller;
  final String labelText;
  final Widget? suffixIcon;
  final bool isVisible;
  final bool isEnabled;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: controller,
            enabled: isEnabled,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: labelText,
              border: const OutlineInputBorder(),
              disabledBorder: const OutlineInputBorder(),
              suffixIcon: suffixIcon,
            ),
          ),
          suffixIcon??SizedBox.shrink(),
        ],
      ),
    );
  }
}
