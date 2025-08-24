import 'package:murza_app/core/failure/app_result.dart';
import '../models/order_model.dart';

abstract class IOrderRepository {
  Future<ApiResult> getOrders();
  Future<ApiResult> getOrderById(int id);
  Future<ApiResult> newOrder(Map<String, dynamic> json);
}

