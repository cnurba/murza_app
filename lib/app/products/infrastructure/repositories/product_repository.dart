import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/app/products/domain/repositories/i_product_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/failure/auth_failure.dart';
import 'package:murza_app/core/http/endpoints.dart';
import 'package:murza_app/core/http/handle_failure.dart';

class ProductRepository implements IProductRepository {
  final Dio _dio;

  const ProductRepository(this._dio);

  @override
  Future<ApiResult> getProducts() async {
    return await handleFailure<ApiResult>(() async {
      log("START PRODUCTS ");
      final responseData = await _dio.get(Endpoints.product.products);
      final products = (responseData.data as List)
          .map((products) => Product.fromJson(products))
          .toList();
      log("FINISH PRODUCTS length  ${products.length}");
      return ApiResultWithData(data: products);
    });
  }

  @override
  Future<AuthFailure> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<AuthFailure> getProduct(int id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<AuthFailure> postProduct(Product product) {
    // TODO: implement postProduct
    throw UnimplementedError();
  }

  @override
  Future<AuthFailure> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<ApiResult> getProductsByBrandId(int brandId) async{
    return await handleFailure<ApiResult>(() async {
      log("START PRODUCTS BY BRAND ID");
      final responseData = await _dio.get(Endpoints.product.productsByBrandId(brandId));
      final products = (responseData.data as List)
          .map((products) => Product.fromJson(products))
          .toList();
      log("FINISH PRODUCTS BY BRAND ID length  ${products.length}");
      return ApiResultWithData(data: products);
    });
  }
}
