import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:murza_app/app/profile/domain/models/user_model.dart';
import 'package:murza_app/auth/domain/models/token.dart';
import 'package:murza_app/auth/domain/repositories/i_auth_api_service.dart';
import 'package:murza_app/auth/domain/repositories/i_secure_storage.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/http/endpoints.dart';
import 'package:murza_app/core/http/handle_failure.dart';

class AuthApiService implements IAuthApiService {
  //final Authenticator _authenticator;
  final ISecureStorage _secureStorage;
  final Dio _dio;

  const AuthApiService(this._dio, this._secureStorage);

  @override
  Future<bool> isSignIn() async {
    final token = await _secureStorage.read();
    return token != null;
  }

  @override
  Future<void> signOut() async {
    await _secureStorage.clear();
  }

  @override
  Future<ApiResult> login(String username, String password) async {
    return await handleFailure<ApiResult>(() async {
      log("LOGIN START}");
      final responseData = await _dio.post(
        Endpoints.auth.login,
        data: {"username": username, "password": password},
      );
      log("FINISH LOGIN ${responseData.data.toString()}");
      await _secureStorage.save(Token.fromMap(responseData.data));
      return ApiResultWithData(data: Token.fromMap(responseData.data));
    });
  }

  @override
  Future<ApiResult> getUserInfo() async {
    return await handleFailure<ApiResult>(() async {
      log("CURRENT USER START}");
      final responseData = await _dio.get(Endpoints.auth.currentUser);
      log("FINISH CURRENT USER ${responseData.data.toString()}");
      final userModel = UserModel.fromJson(responseData.data);
      return ApiResultWithData<UserModel>(data: userModel);
    });
  }
}
