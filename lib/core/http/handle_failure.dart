import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:murza_app/core/failure/app_result.dart';

Future<T> handleFailure<T>(Future<T> Function() callback) async {
  try {
    return await callback();
  } on FormatException catch (e) {
    log("${e.message}: ${e.source}", level: 2);
    return ApiResultWithData(data: e) as T;
  } on DioException catch (e) {
    if (e.response != null) {
      //log("Response data: ${e.response?.data}", level: 2, name: "DioException");
      if (e.response!.statusCode == 403) {
        return ApiResultFailureClient(message: "Недостаточно прав!") as T;
      }
      return ApiResultFailureClient(message: e.response?.data) as T;
    }
    log("${e.message}: ${e.type}", level: 2, name: "DioException");
    return ApiResultWithData(data: e) as T;
  } on PlatformException catch (e) {
    log("${e.message}: ${e.code}", level: 2, name: "PlatformException");
    return ApiResultWithData(data: e) as T;
  } catch (e) {
    log(e.toString(), level: 2, name: "Exception");
    return ApiResultWithData(data: e) as T;
  }
}
