import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:murza_app/app/clients/domain/repositories/i_client_repository.dart';
import 'package:murza_app/app/clients/infrastructure/repositories/client_repository.dart';
import 'package:murza_app/app/products/domain/repositories/i_product_repository.dart';
import 'package:murza_app/app/products/infrastructure/repositories/product_repository.dart';
import 'package:murza_app/app/profile/domain/repositories/i_user_model_cache.dart';
import 'package:murza_app/app/profile/infrastructure/repositories/user_model_cache.dart';
import 'package:murza_app/auth/domain/repositories/i_auth_api_service.dart';
import 'package:murza_app/auth/domain/repositories/i_secure_storage.dart';
import 'package:murza_app/auth/infrastructure/repositories/auth_api_service.dart';
import 'package:murza_app/auth/infrastructure/repositories/secure_storage.dart';
import 'package:murza_app/core/http/dio_interceptor.dart';

/// The instance of [GetIt]
final GetIt getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<ISecureStorage>(() => SecureStorage(getIt()));
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioInterceptor>(
    () => DioInterceptor(getIt(), getIt()),
  );

  getIt.registerLazySingleton<IUserModelCache>(() => UserModelCache());

  getIt.registerLazySingleton<IAuthApiService>(
    () => AuthApiService(getIt<Dio>(), getIt<ISecureStorage>()),
  );
  getIt.registerLazySingleton<IProductRepository>(
    () => ProductRepository(getIt()),
  );
  getIt.registerLazySingleton<IClientRepository>(
        () => ClientRepository(getIt()),
  );
}
