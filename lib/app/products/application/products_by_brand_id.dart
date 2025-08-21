
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/products/application/product_list_future_provider.dart';
import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/core/failure/app_result.dart';

final productListByBrandIdFutureProvider = FutureProvider.autoDispose
    .family<List<Product>, int>((ref, brandId) async {
  final productRepository = ref.watch(productRepositoryProvider);
  final result = await productRepository.getProductsByBrandId(brandId);
  if (result is ApiResultWithData<List<Product>>) {
    return result.data;
  } else {
    throw Exception('Failed to load products for brand ID: $brandId');
  }
});