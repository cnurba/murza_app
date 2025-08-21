import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/auth/application/new_login/new_login_controller.dart';
import 'package:murza_app/auth/application/new_login/new_login_state.dart';

/// This provider is used to manage the state of a new user registration.
final newLoginProvider =
    StateNotifierProvider<NewLoginController, NewLoginState>(
      (ref) => NewLoginController(),
    );
