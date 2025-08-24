import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:murza_app/app/profile/domain/models/user_model.dart';
import 'package:murza_app/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/http/endpoints.dart';

class ProfileRepository implements IProfileRepository {
  // Repository methods here
  final Dio _dio;

  const ProfileRepository(this._dio);

  @override
  Future<ApiResult> getCurrentUser() async {
    /// Implement the method to get current user profile
    try {
      log("START GET CURRENT USER PROFILE");
      final responseData = await _dio.get(
        Endpoints.auth.currentUser,
      ); // Example endpoint
      final UserModel user = UserModel.fromJson(responseData.data);
      log("END GET CURRENT USER PROFILE");
      return ApiResultWithData(data: user);
    } catch (e) {
      return ApiResultFailureClient(
        message: "Ошибка получения профиля пользователя",
      );
    }
  }
}
