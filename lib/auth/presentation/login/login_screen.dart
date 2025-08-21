import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/auth/application/auth/auth_provider.dart';
import 'package:murza_app/auth/presentation/login/sign_in_form.dart';

import 'package:murza_app/auth/presentation/widgets/welcome_text.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';
import 'package:murza_app/core/failure/app_result.dart';

import '../../../core/presentation/messages/messenger.dart';
import '../../application/login/login_provider.dart';

final GlobalKey buttonKey = GlobalKey();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        // title: const Text("Войти в аккаунт"),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeText(
                title: "Добро пожаловать",
                text: "Введите ваш Email \nадрес для входа в аккаунт.",
              ),
              const SignInForm(),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, child) {
                  // Access the login state from the provider
                  final loginState = ref.watch(loginProvider);

                  //loginState.stateType.when(initial: , loading: loading, loaded: loaded, error: error)
                  switch (loginState.stateType) {
                    case BlocStateType.initial:
                      return Container();
                    case BlocStateType.loading:

                      /// Show loading dialog
                      return const Center(child: CircularProgressIndicator());
                    case BlocStateType.loaded:
                      final successMessage = "Вы успешно вошли в аккаунт";
                      showSuccessMessage(context, successMessage);

                      /// Restart app after 1 second
                      Future.delayed(const Duration(seconds: 1), () {
                        ref.read(authProvider.notifier).authCheckRequest();
                        // RestartWidget.restartApp(context);
                      });
                    case BlocStateType.error:
                      final errorMessage =
                          (loginState.apiResult as ApiResultFailureClient)
                              .message;
                      showErrorMessage(context, buttonKey, errorMessage);
                  }

                  // // Check the state and return appropriate widgets
                  // if (loginState.apiResult is ApiResultFailureClient) {
                  //   /// Show scaffold snackbar with error message in center of screen
                  //   final errorMessage = (loginState.apiResult as ApiResultFailureClient).message;
                  //    showErrorMessage(context, buttonKey, errorMessage);
                  // }else if(loginState.apiResult is ApiResultWithData) {
                  //   /// Show scaffold snackbar with success message in center of screen
                  //
                  // }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
