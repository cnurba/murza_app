import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:murza_app/app/brands/domain/models/brand.dart';
import 'package:murza_app/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/clients/domain/repositories/i_client_repository.dart';
import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/app/products/domain/repositories/i_product_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/http/endpoints.dart';
import 'package:murza_app/core/http/handle_failure.dart';

class BrandRepository implements IBrandRepository {
  final Dio _dio;
  const BrandRepository(this._dio);
  @override
  Future<ApiResult> getBrands() async {
    return await handleFailure<ApiResult>(() async {
      log("START BRANDS ");
      final responseData = await _dio.get(Endpoints.brand.brands);
      final brands = (responseData.data as List)
          .map((clients) => Brand.fromJson(clients))
          .toList();
      log("FINISH BRANDS length  ${brands.length}");
      return ApiResultWithData<List<Brand>>(data: brands);
    });
  }
}
