import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/profile/domain/repositories/i_user_model_cache.dart';
import 'package:murza_app/auth/domain/repositories/i_auth_api_service.dart';
import 'package:murza_app/core/failure/app_result.dart';

part 'auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  /// Creates a NewOrderController with an initial state.
  AuthController(this._api, this._userModelCache) : super(AuthInitial());

  final IAuthApiService _api;
  final IUserModelCache _userModelCache;

  /// Login function with _api.

  Future<void> authCheckRequest() async {
    state = AuthLoading();
    try {
      final isSignedIn = await _api.isSignIn();
      log("Auth check result: $isSignedIn");
      if (isSignedIn) {
        // final userInfoResult = await _api.getUserInfo();
        // if (userInfoResult is ApiResultWithData) {
        //   log("User info fetch success: ${userInfoResult.data}");
        //   _userModelCache.setUserModel(userInfoResult.data);
          state = AuthAuthenticated();
          return;
        //}
        //state = AuthAuthenticated();
      } else {
        state = AuthUnAuthenticated();
      }
    } catch (e) {
      log("Auth check error: $e");
      state = AuthUnAuthenticated();
    }
  }

  Future<void> signOut() async {
    state = AuthLoading();
    try {
      await _api.signOut();
      log("Sign out successful");
      state = AuthUnAuthenticated();
    } catch (e) {
      log("Sign out error: $e");
      state = AuthUnAuthenticated();
    }
  }
}
