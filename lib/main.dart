import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/core/http/dio_interceptor.dart';
import 'package:murza_app/injection.dart';
import 'package:murza_app/murza_sales_app.dart';

import 'core/provider/provider_logger.dart';

void main() async {
  await _appInitializer();
}

/// Initializes dependencies.
Future<void> _appInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  getIt<Dio>()
    ..options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 60 * 1000),
      receiveTimeout: const Duration(milliseconds: 3000),
    )
    ..interceptors.add(getIt<DioInterceptor>());
  //configureInjection(Environment.prod);
  runApp(ProviderScope(observers: [Logger()], child: const MurzaSalesApp()));
}
