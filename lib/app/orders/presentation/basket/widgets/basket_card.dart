import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_provider.dart';

class BasketCard extends ConsumerWidget {
  const BasketCard( {super.key,this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketData = ref.watch(basketProvider);
    if (basketData.products.isEmpty) {
      return SizedBox.shrink();
    }
    final totalPrice = basketData.products.fold<double>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_basket,
              color: Colors.green,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              '$totalPrice c',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}