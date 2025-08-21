import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneEditField extends StatelessWidget {
  PhoneEditField({
    super.key,
    this.onChanged,
    this.onSaved,
    this.errorText,
    this.validator,
  });

  final ValueChanged<String>? onChanged;
  final void Function(String?)? onSaved;
  final String? errorText;
  final String? Function(String?)? validator;

  final maskFormatter = MaskTextInputFormatter(
    mask: '+996 ###-##-##-##',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF4F4F4),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          labelText: 'Телефон',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: [maskFormatter],
        validator: (value) {
          if (value == null || value.isEmpty) return 'Введите телефон';
          //if (!maskFormatter.isFill()) return 'Введите полностью';
          return null;
        },
        onChanged: onChanged,
        onSaved: onSaved,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}