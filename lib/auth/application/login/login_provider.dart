import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/auth/application/auth/auth_controller.dart';
import 'package:murza_app/auth/application/auth/auth_provider.dart';
import 'package:murza_app/auth/application/login/login_controller.dart';
import 'package:murza_app/auth/application/login/login_state.dart';
import 'package:murza_app/auth/domain/repositories/i_auth_api_service.dart';
import 'package:murza_app/injection.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>((ref) {
      // Access the AuthController to check if the user is already signed in
      //ref.refresh(authProvider);

      // If the user is already signed in, redirect to the home screen
      // Uncomment the following lines if you want to redirect to home screen
      // if (authController.isSignedIn) {
      //   Future.microtask(() {
      //     authController.redirectToHome();
      //   });

      // // If the user is already signed in, redirect to the home screen
      // if (authController.) {
      //   Future.microtask(() {
      //     authController.redirectToHome();
      //   });
      // }

      // Return an instance of LoginController with the AuthApiService
      return LoginController(getIt<IAuthApiService>());
    });
