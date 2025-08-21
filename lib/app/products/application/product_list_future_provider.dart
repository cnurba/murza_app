import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/app/products/domain/repositories/i_product_repository.dart';
import 'package:murza_app/app/products/infrastructure/repositories/product_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/injection.dart';

final productRepositoryProvider = Provider<IProductRepository>(
  (ref) => ProductRepository(getIt<Dio>()),
);

final productListFutureProvider = FutureProvider.autoDispose<List<Product>>((
  ref,
) async {
  final productRepository = ref.watch(productRepositoryProvider);
  final result = await productRepository.getProducts();
  if (result is ApiResultWithData<List<Product>>) {
    return result.data;
  } else {
    throw Exception('Failed to load products');
  }
});

