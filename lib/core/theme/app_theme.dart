import 'package:flutter/material.dart';
import 'package:murza_app/core/theme/colors.dart';

class AppTheme {
  static ThemeData lightTheme = _buildLightAppTheme();

  static ThemeData _buildLightAppTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      textTheme: _lightTextTheme(base.textTheme),
      primaryColor: MurzaColors.primaryColor,
      scaffoldBackgroundColor: MurzaColors.scaffoldBackgroundColor,
      cardTheme: base.cardTheme.copyWith(
        color: MurzaColors.scaffoldBackgroundColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static TextTheme _lightTextTheme(TextTheme baseTextTheme) {
    return baseTextTheme.copyWith();
  }
}
