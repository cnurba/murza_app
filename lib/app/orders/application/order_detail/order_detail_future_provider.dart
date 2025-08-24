import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:murza_app/app/orders/domain/repositories/i_order_repository.dart';
import 'package:murza_app/app/orders/infrastructure/repositories/order_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/injection.dart';

import '../new_order/new_order_post_future_provider.dart';


final orderDetailFutureProvider = FutureProvider.autoDispose
    .family<ApiResult, int>((ref, id) async {
  final orderRepository = ref.watch(orderRepositoryProvider);
  final result = await orderRepository.getOrderById(id);
  return result;
});
