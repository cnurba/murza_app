import 'dart:developer';

import 'package:flutter/material.dart';

/// Обертка для таб-ов, чтобы можно было получить доступ к [Navigator] дочернего таб-а.
///
/// Для использования нужно передать ключ.
///
///
class TabNavigatorHolder extends StatefulWidget {
  const TabNavigatorHolder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  TabNavigatorHolderState createState() => TabNavigatorHolderState();
}

class TabNavigatorHolderState extends State<TabNavigatorHolder> {
  NavigatorState get navigator => Navigator.of(context);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async{
        log('TabHolderState.build.onPopInvokedWithResult');

      },

      child: widget.child,
    );
  }
}
