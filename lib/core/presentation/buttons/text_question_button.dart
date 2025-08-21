import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:murza_app/core/theme/colors.dart';

class TextQuestionButton extends StatelessWidget {
  const TextQuestionButton({
    super.key,
    required this.title,
    required this.actionText,
    this.onPressed,
  });

  final String title;
  final String actionText;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
            color: MurzaColors.blackColor,
          ),
          children: [
            TextSpan(
              text: " $actionText",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()..onTap = onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
