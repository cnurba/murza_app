import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_provider.dart';
import 'package:murza_app/app/orders/application/new_order/new_order_post_future_provider.dart';
import 'package:murza_app/app/orders/presentation/order/checkout_order_item.dart';
import 'package:murza_app/app/orders/presentation/order/widgets/checkout_summary_card.dart';
import 'package:murza_app/app/orders/presentation/order/widgets/checkout_title.dart';
import 'package:murza_app/app/orders/presentation/order/widgets/client_selected_widget.dart';
import 'package:murza_app/core/extensions/router_extension.dart';
import 'package:murza_app/core/failure/app_result.dart';

class CheckoutOrderScreen extends ConsumerWidget {
  const CheckoutOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketData = ref.watch(basketProvider);

    /// amount of products in the basket
    final totalAmount = basketData.products.fold<double>(
      0,
      (sum, item) => sum + (item.amount),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Оформление заказа',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          ///
          ///
          //ref.refresh(newOrderPostFutureProvider)
          /// create new order action with newOrderPostFutureProvider.
          //ref.read(newOrderPostFutureProvider.notifier).createNewOrder(basketData);
          final result = await ref.refresh(
            newOrderPostFutureProvider(basketData),
          );

          if (result is ApiResultWithData) {
            // If the order was created successfully, clear the basket
            ref.read(basketProvider.notifier).clearSelectedProducts();
            context.pop(); // Close the checkout screen
          } else {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ошибка при создании заказа')),
            );
          }
        },
        label: Text('Оформить заказ на сумма $totalAmount с'),
        icon: const Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckoutTitle(title: "Данные доставки:"),

            ClientSelectedWidget(),
            // Order Summary Section
            CheckoutTitle(title: "Ваш заказ:"),

            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: basketData.products.length,
              itemBuilder: (context, index) {
                final product = basketData.products[index];
                return CheckoutOrderItem(
                  basketItem: product,
                  isLast: index == basketData.products.length - 1,
                );
              },
            ),
            const SizedBox(height: 32),
            CheckoutSummaryCard(totalAmount: totalAmount),
          ],
        ),
      ),
    );
  }
}
