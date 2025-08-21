import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/auth/application/new_login/new_login_state.dart';

class NewLoginController extends StateNotifier<NewLoginState> {
  /// Creates a NewOrderController with an initial state.
  NewLoginController() : super(NewLoginState.initial());

  /// Updates the state with the provided values.
  void update({String? username, String? password, bool? checkingMode}) {
    state = state.copyWith(
      username: username ?? state.username,
      password: password ?? state.password,
      checkingMode: checkingMode ?? state.checkingMode,
    );
  }

  /// Resets the state to its initial values.
  void reset() {
    state = NewLoginState.initial();
  }

  /// CHECKS IF THE USER IS VALID
  bool isValid() {
    return state.username.isNotEmpty && state.password.isNotEmpty;
  }

  bool validate() {
    update(checkingMode: true);
    if (isValid()) {
      return true;
    }
    return false;
  }
}
