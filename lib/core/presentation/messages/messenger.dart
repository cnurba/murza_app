import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, GlobalKey key, String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOverlayMessage(context, key, message);
    });
}

void _showOverlayMessage(BuildContext context, GlobalKey key, String message) {
  final overlay = Overlay.of(context);
  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
  final Size size = renderBox.size;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      right: offset.dx,
      top: offset.dy + size.height + 16, // чуть ниже кнопки
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
}
Future<void> _showSuccessMessage(BuildContext context,String successMessage) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(successMessage),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}

void showSuccessMessage(BuildContext context, String message){
  WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSuccessMessage(context, message);
    });
}