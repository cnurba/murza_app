import 'package:murza_app/core/failure/app_result.dart';

/// Describe authorization api methods.
abstract class IAuthApiService {
  /// Sign up user in the system
  Future<ApiResult> login(String username, String password);

  Future<void> signOut();

  /// Check if user is signed in.
  Future<bool> isSignIn();

  Future<ApiResult> getUserInfo();
}
