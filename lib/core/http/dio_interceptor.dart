import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:murza_app/auth/domain/models/token.dart';
import 'package:murza_app/auth/domain/repositories/i_secure_storage.dart';
import 'package:murza_app/core/http/endpoints.dart';

class DioInterceptor extends Interceptor {
  final Dio dio;
  Future<Token?>? _refreshTokenFuture;
  final ISecureStorage tokenStorage; // a class that reads/writes tokens
  DioInterceptor(this.dio, this.tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await tokenStorage.read();
    if (accessToken != null && accessToken.access.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${accessToken.access}';
      //log(accessToken.access);
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_isUnauthorized(err) && _shouldRefresh(err.requestOptions)) {
      // Attempt refresh if not already happening
      _refreshTokenFuture ??= _refreshAccessToken();

      final newToken = await _refreshTokenFuture;
      if (newToken != null) {
        // Retry the original request
        final clonedRequest = _retryRequest(err.requestOptions, newToken);
        try {
          final response = await dio.fetch(clonedRequest);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(e as DioException);
        }
      }
      // If refresh fails, newToken == null => pass the 401 up
    }
    return handler.next(err);
  }

  bool _isUnauthorized(DioException err) {
    return err.response?.statusCode == 401;
  }

  bool _shouldRefresh(RequestOptions requestOptions) {
    // Avoid refreshing again if it's the refresh token call
    return !requestOptions.path.contains('/refresh');
  }

  RequestOptions _retryRequest(RequestOptions requestOptions, Token newToken) {
    final newHeaders = Map<String, dynamic>.from(requestOptions.headers);
    newHeaders['Authorization'] = 'Bearer ${newToken.access}';
    return requestOptions.copyWith(headers: newHeaders);
  }

  Future<Token?> _refreshAccessToken() async {
    try {
      // Call your /refresh endpoint
      final response = await Dio().post(
        Endpoints.auth.refresh,
        data: {'refresh_token': (await tokenStorage.read())?.refresh},
      );
      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];
      //final newAccessToken = 'FAKE_NEW_TOKEN';
      final token = Token(access: newAccessToken, refresh: newRefreshToken);
      await tokenStorage.save(token);
      return token;
    } catch (e) {
      // If fail, remove token or force user to re-log
      await tokenStorage.clear();
      return null;
    } finally {
      // Allow future refresh attempts next time 401 is encountered
      _refreshTokenFuture = null;
    }
  }
}
