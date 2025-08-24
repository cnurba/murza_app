import 'package:murza_app/core/failure/app_result.dart';

abstract class IProfileRepository {
  Future<ApiResult> getCurrentUser();
}
