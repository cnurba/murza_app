import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/auth/application/login/login_state.dart';
import 'package:murza_app/auth/domain/repositories/i_auth_api_service.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';

class LoginController extends StateNotifier<LoginState> {
  /// Creates a NewOrderController with an initial state.
  LoginController(this._api) : super(LoginState.initial());

  final IAuthApiService _api;

  /// Login function with _api.
  Future<void> login(String username, String password) async {
    state = state.copyWith(stateType: BlocStateType.loading);
    try {
      final result = await _api.login(username, password);
      log("Login result: $result");
      state = state.copyWith(
        stateType: BlocStateType.loaded,
        apiResult: result,
      );
    } catch (e) {
      log("Login error: $e");
      state = state.copyWith(
        stateType: BlocStateType.error,
        //apiResult: ApiResultWithError(error: e.toString()),
      );
    }
  }

  /// Resets the state to its initial values.
  void reset() {
    state = LoginState.initial();
  }
}
