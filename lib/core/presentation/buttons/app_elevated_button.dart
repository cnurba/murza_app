import 'package:flutter/material.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';
import 'package:murza_app/core/theme/colors.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({super.key, this.onPressed, required this.title});

  final VoidCallback? onPressed;

  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: MurzaColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title),
    );
  }
}
