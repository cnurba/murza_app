import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/orders/application/order_list/order_list_future_provider.dart';
import 'package:murza_app/app/orders/domain/models/order_model.dart';
import 'package:murza_app/app/orders/presentation/orders/order_detail_screen.dart';
import 'package:murza_app/core/extensions/router_extension.dart';
import 'package:murza_app/core/failure/app_result.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(orderListFutureProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Заказы', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket, color: Colors.green),
          ),
        ],
      ),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка загрузки заказов')),
        data: (apiResult) {
          if (apiResult is ApiResultWithData<List<OrderModel>>) {
            final orders = apiResult.data;
            if (orders.isEmpty) {
              return Center(child: Text('Нет заказов'));
            }
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.85,
              ),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return GestureDetector(
                  onTap: () {
                    context.push(OrderDetailScreen(orderId: order.id));
                  },
                  child: _OrderCard(order: order),
                );
              },
            );
          } else {
            return Center(child: Text('Ошибка получения данных'));
          }
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '№${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Chip(
                  label: Text(
                    order.status,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: order.status == 'new'
                      ? Colors.green[100]
                      : Colors.grey[200],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Сумма: ${order.totalAmount.toStringAsFixed(2)} ₽',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              'Дата доставки:',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            Text(
              '${order.deliveryDate.day.toString().padLeft(2, '0')}.${order.deliveryDate.month.toString().padLeft(2, '0')}.${order.deliveryDate.year}',
              style: const TextStyle(fontSize: 15),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
