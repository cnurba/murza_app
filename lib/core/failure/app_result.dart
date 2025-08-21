
import 'package:equatable/equatable.dart';

sealed class ApiResult extends Equatable {
  @override
  List<Object> get props => [];

  Future<dynamic> fold<T>(Function(ApiResult failure) param0,
      T Function(ApiResult success) param1) async {
    if (this is ApiResultWithData) {
      return param1(this);
    }
    return param0(this);
  }
}

class ApiResultInitial extends ApiResult {}

class ApiResultWithData<T> extends ApiResult {
  final T data;

  ApiResultWithData({required this.data});
}

class ApiResultFailureServer extends ApiResult {
  final int code;
  final String message;

  ApiResultFailureServer({required this.code, required this.message});
}

class ApiResultFailureClient extends ApiResult {
  final String message;

  ApiResultFailureClient({required this.message});
}

class ApiResultFailureNoConnection extends ApiResult {}

class ApiResultFailureStorage extends ApiResult {}

class ApiResultFailureTokenExpired extends ApiResult {}

class ApiResultFailureUnExpected extends ApiResult {}

class ApiResultFailureConfirmCode extends ApiResult {}
