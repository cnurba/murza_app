import 'package:flutter/material.dart';

extension RouterExtension on BuildContext {
  /// Pushes a new route onto the navigator stack.
  Future<T?> push<T extends Object?>(Widget screen, {Object? arguments}) {
    return Navigator.of(this).push(
      MaterialPageRoute<T>(
        builder: (context) => screen,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  /// Replaces the current route with a new one.
  Future<T?> pushReplacement<T extends Object?>(Widget screen,
      {Object? arguments}) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute<T>(
        builder: (context) => screen,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }
  /// Pops the current route off the navigator stack.
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }


}
