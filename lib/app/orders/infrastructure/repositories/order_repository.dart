import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:murza_app/app/orders/domain/models/order_detail_model.dart';
import 'package:murza_app/app/orders/domain/models/order_model.dart';
import 'package:murza_app/app/orders/domain/repositories/i_order_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/http/endpoints.dart';
import 'package:murza_app/core/http/handle_failure.dart';

class OrderRepository implements IOrderRepository {
  final Dio _dio;

  const OrderRepository(this._dio);

  @override
  Future<ApiResult> getOrders() async {
    return await handleFailure<ApiResult>(() async {
      log("START GET ORDERS");
      final responseData = await _dio.get(Endpoints.orders.orders);
      final orders = (responseData.data as List)
          .map((order) => OrderModel.fromJson(order))
          .toList();
      log("FINISH ORDERS length  \\${orders.length}");
      return ApiResultWithData<List<OrderModel>>(data: orders);
    });
  }

  @override
  Future<ApiResult> newOrder(Map<String, dynamic> json) async {
    try {
      log("START CREATE NEW ORDER");
      final responseData = await _dio.post(
        Endpoints.orders.ordersPost,
        data: json,
      );
      log("FINISH NEW ORDER");
      return ApiResultWithData(data: true);
    } catch (e) {
      log("Error validating order model: \\${e}");
      return ApiResultFailureClient(message: "Ошибка валидации заказа");
    }
  }

  @override
  Future<ApiResult> getOrderById(int id) async {
    try {
      log("START GET ORDER BY ID $id");
      final responseData = await _dio.get(
        Endpoints.orders.ordersDetailById(id),
        //queryParameters: {"order_id": id},
      );
      final OrderDetailModel order = OrderDetailModel.fromJson(responseData.data);
      log("FINISH GET ORDER BY ID $id");
      return ApiResultWithData(data: order);
    } catch (e) {
      log("Error validating order model: \\${e}");
      return ApiResultFailureClient(message: "Ошибка валидации заказа");
    }
  }
}
