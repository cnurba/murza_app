import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:murza_app/core/failure/status_code.dart';

class AuthFailure extends Equatable {
  final DataStatus dataStatus;
  final String message;

  const AuthFailure({required this.dataStatus, this.message = ''});

  factory AuthFailure.initial() =>
      const AuthFailure(dataStatus: DataStatus.initial);

  @override
  List<Object> get props => [dataStatus];

  String getMessage(BuildContext context) {
    if (message.isNotEmpty) {
      return message;
    }

    switch (dataStatus) {
      case DataStatus.initial:
        return "";
      case DataStatus.noContent:
        return "success with no data (no content)";
      case DataStatus.success:
        return "success with data";
      case DataStatus.badRequest:
        return "Bad request. try again later";
      case DataStatus.forbidden:
        return "Bad request. try again later";
      case DataStatus.notFound:
        return "url not found, try again later";
      case DataStatus.internalServerError:
        return "some thing went wrong, try again later";
      case DataStatus.noConnection:
        return "Please check your internet connection";
      case DataStatus.unauthorized:
        return "user is not authorised";
      case DataStatus.responseTimeout:
        return "time out, try again late";
      case DataStatus.sendTimeout:
        return "time out, try again late";
      case DataStatus.cacheError:
        return "cache error, try again late";
      case DataStatus.connectionTimeout:
        return "connection time out, try again late";
      case DataStatus.cancel:
        return "cancelled";
      case DataStatus.invalidOTP:
        return "Invalid OTP";
      case DataStatus.hasUser:
        return "User already exist";
      case DataStatus.smsLimitExceeded:
        return "SMS limit exceeded";
      case DataStatus.userNotFound:
        return "User not found";
      case DataStatus.userAlreadyVerified:
        return "User already verified";
      case DataStatus.userNotVerified:
        return "User not verified";
      case DataStatus.clientError:
        return "Client Error";
      case DataStatus.defaultError:
        return "some thing went wrong, try again later";
      case DataStatus.badInput:
        return "Bad Input";
      case DataStatus.invalidPassword:
        return "Invalid Password";
      case DataStatus.quizNotFount:
        return "Quiz not found";
      case DataStatus.tokenExpired:
        return "";
      case DataStatus.userUnAuthorized:
        //context.read<AuthBloc>().add(const SignedOut());
        return "Token Expired";
      case DataStatus.invalidGoogleToken:
        return "Invalid firebase id token";
      case DataStatus.noPaymentPlan:
        return "Subscription plan does not meet the required level.";
      default:
        return "UnExpected";
    }
  }

  map(
    Function(AuthFailure initial) paramInitial,
    Function(AuthFailure failure) paramFailure,
    Function(AuthFailure success) paramSuccess,
  ) {
    switch (dataStatus) {
      case DataStatus.initial:
        paramInitial(this);
      case DataStatus.success:
        paramSuccess(this);
      case DataStatus.noContent:
        paramSuccess(this);

      default:
        paramFailure(this);
    }
  }

  fold<T>(
    Function(AuthFailure initial) paramInitial,
    Function(AuthFailure failure) paramFailure,
    Function(AuthFailure success) paramSuccess,
  ) {
    switch (dataStatus) {
      case DataStatus.initial:
        return paramInitial(this);
      case DataStatus.success:
        return paramSuccess(this);
      case DataStatus.noContent:
        return paramSuccess(this);

      default:
        return paramFailure(this);
    }
  }
}
