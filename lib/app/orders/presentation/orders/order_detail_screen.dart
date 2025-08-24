import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:murza_app/app/orders/application/order_detail/order_detail_future_provider.dart';
import 'package:murza_app/app/orders/domain/models/order_detail_model.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/presentation/global/loader.dart';

class OrderDetailScreen extends ConsumerWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetailAsync = ref.watch(orderDetailFutureProvider(orderId));
    return Scaffold(
      appBar: AppBar(title: const Text('Детали заказа')),
      body: orderDetailAsync.map(
        data: (data) {
          final result = data.value;
          if (result is ApiResultWithData<OrderDetailModel>) {
            return _buildOrder(result.data);
          } else if (result is ApiResultInitial) {
            return Loader();
          } else {
            return const Center(child: Text('Неизвестная ошибка'));
          }
        },
        loading: (_) => const Center(child: CircularProgressIndicator()),
        error: (error) =>
            Center(child: Text('Ошибка загрузки: ${error.error}')),
      ),

    );
  }

  Widget _buildOrder(OrderDetailModel order) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('ID заказа: ${order.id}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Статус: ${order.status}'),
        const SizedBox(height: 8),
        Text('Дата доставки: ${DateFormat('dd.MM.yyyy').format(
            order.deliveryDate)}'),
        const SizedBox(height: 8),
        Text('Сумма: ${order.totalAmount.toStringAsFixed(2)} c'),
        const SizedBox(height: 8),
        if (order.comment.isNotEmpty) ...[
          Text('Комментарий: ${order.comment}'),
          const SizedBox(height: 8),
        ],
        const Divider(),
        const Text('Товары:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...order.items.map((item) =>
            ListTile(
              title: Text('Товар ID: ${item.productId}'),
              subtitle: Text('Кол-во: ${item.quantity}, Цена: ${item.unitPrice
                  .toStringAsFixed(2)} c'),
              trailing: Text('${item.totalPrice.toStringAsFixed(2)} c'),
            )),
        const Divider(),
        Text('Создан: ${DateFormat('dd.MM.yyyy HH:mm').format(
            order.createdAt)}'),
        Text('Обновлен: ${DateFormat('dd.MM.yyyy HH:mm').format(
            order.updatedAt)}'),
      ],
    );
  }
}
