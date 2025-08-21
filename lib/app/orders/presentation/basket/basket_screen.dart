import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_provider.dart';
import 'package:murza_app/app/orders/presentation/basket/widgets/basket_item_card.dart';
import 'package:murza_app/core/extensions/router_extension.dart';

class BasketScreen extends ConsumerWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketData = ref.watch(
      basketProvider,
    ); // Watch the selected products state
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.pop(false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton.icon(
            label: Text("Очистить корзину"),
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(basketProvider.notifier).clearSelectedProducts();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pop(true);
        },
        label: const Text('Оформить заказ'),
        icon: const Icon(Icons.check),
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            //padding: const EdgeInsets.all(8),
            itemCount: basketData.products.length,
            // Replace with your actual item count
            itemBuilder: (context, index) {
              return BasketItemCard(
                productState: basketData.products.elementAt(index),
                onQuantityChanged: (quantity) {
                  ref
                      .read(basketProvider.notifier)
                      .addProduct(
                        basketData.products.elementAt(index).product,
                        quantity,
                      );
                },
                onDelete: () {
                  ref
                      .read(basketProvider.notifier)
                      .removeProduct(
                        basketData.products.elementAt(index).product.id,
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
