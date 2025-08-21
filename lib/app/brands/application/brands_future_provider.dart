import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:murza_app/app/brands/infrastructure/repositories/brand_repository.dart';
import 'package:murza_app/app/clients/domain/repositories/i_client_repository.dart';
import 'package:murza_app/app/clients/infrastructure/repositories/client_repository.dart';
import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/app/products/domain/repositories/i_product_repository.dart';
import 'package:murza_app/app/products/infrastructure/repositories/product_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/injection.dart';

final brandsRepositoryProvider = Provider<IBrandRepository>(
  (ref) => BrandRepository(getIt<Dio>()),
);

final brandsFutureProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
  final brandRepository = ref.watch(brandsRepositoryProvider);
  final result = await brandRepository.getBrands();
  return result;
});
