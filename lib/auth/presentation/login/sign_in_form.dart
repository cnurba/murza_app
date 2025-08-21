import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/auth/application/login/login_provider.dart';
import 'package:murza_app/auth/application/new_login/new_login_provider.dart';
import 'package:murza_app/auth/presentation/login/login_screen.dart';
import 'package:murza_app/core/presentation/buttons/app_elevated_button.dart';
import 'package:murza_app/core/presentation/buttons/text_question_button.dart';
import 'package:murza_app/core/presentation/textforms/app_password_field.dart';
import 'package:murza_app/core/presentation/textforms/app_underline_text_field.dart';

class SignInForm extends ConsumerWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        AppUnderlineTextField(
          prefixIcon: Icons.person,
          hintText: "Логин",
          errorText: errorTextUserName(ref),
          onChanged: (value) {
            ref.read(newLoginProvider.notifier).update(username: value);
          },
        ),
        AppPasswordField(
          prefixIcon: Icons.lock,
          hintText: "Пароль",
          errorText: errorTextRepeatPassword(ref),
          onChanged: (value) {
            ref.read(newLoginProvider.notifier).update(password: value);
          },
        ),

        const SizedBox(height: 32),
        // Sign In Button
        AppElevatedButton(
          key: buttonKey,
          title: "Войти",
          onPressed: () {
            /// Закрыть клавиатуру
            FocusScope.of(context).unfocus();
            if (ref.read(newLoginProvider.notifier).validate()) {
              final username = ref.read(newLoginProvider).username;
              final password = ref.read(newLoginProvider).password;
              ref.read(loginProvider.notifier).login(username, password);
            }
          },
        ),
        SizedBox(height: 26),
        TextQuestionButton(
          title: "Забыли пароль?",
          actionText: "Восстановить",
          onPressed: () {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }

  String? errorTextUserName(WidgetRef ref) {
    final username = ref.watch(newLoginProvider).username;
    final checkingMode = ref.watch(newLoginProvider).checkingMode;
    if (!checkingMode) {
      return null; // Если в режиме проверки, не показываем ошибку
    }
    if (username.isEmpty) {
      return 'Введите логин';
    }
    if (username.length < 4) {
      return 'Логин должен содержать не менее 4 символов.';
    }
    // Добавьте дополнительные проверки при необходимости
    return null;
  }

  String? errorTextRepeatPassword(WidgetRef ref) {
    final checkingMode = ref.watch(newLoginProvider).checkingMode;
    if (!checkingMode) {
      return null; // Если в режиме проверки, не показываем ошибку
    }

    final password = ref.watch(newLoginProvider).password;

    if (password.isEmpty) {
      return 'Введите пароль.';
    }

    if (password.length < 6) {
      return 'Пароль должен содержать не менее 6 символов.';
    }
    // Добавьте дополнительные проверки при необходимости
    return null;
  }
}
