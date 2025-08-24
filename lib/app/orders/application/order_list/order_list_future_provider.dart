import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:murza_app/app/orders/domain/repositories/i_order_repository.dart';
import 'package:murza_app/app/orders/infrastructure/repositories/order_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/injection.dart';

final orderRepositoryProvider = Provider<IOrderRepository>(
  (ref) => OrderRepository(getIt<Dio>()),
);

final orderListFutureProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
  final orderRepository = ref.watch(orderRepositoryProvider);
  final result = await orderRepository.getOrders();
  return result;
});

