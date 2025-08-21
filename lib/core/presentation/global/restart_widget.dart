import 'package:flutter/material.dart';

/// Represents widget for restarting app.
///
/// For restarting app root widget of app should be wrapeted by this widget.
class RestartWidget extends StatefulWidget {
  const RestartWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
