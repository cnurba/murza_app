import 'package:flutter/material.dart';

/// Виджет, чтобы показать Android Toast like оповещение.
class Toast extends StatefulWidget {
  const Toast({
    required Key key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  ToastState createState() => ToastState();
}

class ToastState extends State<Toast> {
  static const _toastEffectDuration = Duration(milliseconds: 200);
  var _showToast = false;
  Widget? _toastBody;

  Future<void> showToast({
    required Widget child,
    Duration duration = const Duration(seconds: 3),
  }) async {
    _toastBody = child;
    setState(() => _showToast = true);
    await Future.delayed(duration);
    setState(() => _showToast = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedOpacity(
                duration: _toastEffectDuration,
                opacity: _showToast ? 1 : 0,
                child: _ToastWidget(
                  child: _toastBody,
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToastWidget extends StatelessWidget {
  const _ToastWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child ?? const Text('test'),
    );
  }
}
