import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/failure/auth_failure.dart';

abstract class IProductRepository {
  Future<ApiResult> getProducts();
  Future<ApiResult> getProductsByBrandId(int brandId);
  Future<AuthFailure> postProduct(Product product);
  Future<AuthFailure> deleteProduct(int id);
  Future<AuthFailure> updateProduct(Product product);
  Future<AuthFailure> getProduct(int id);
}
