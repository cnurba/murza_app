import 'package:flutter/material.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_item_state.dart';
import 'package:murza_app/core/presentation/widgets/dashed_divider.dart';

class CheckoutOrderItem extends StatelessWidget {
  const CheckoutOrderItem({super.key, required this.basketItem, this.isLast = false});

  final BasketItemState basketItem;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          basketItem.product.name,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${basketItem.count} X ${basketItem.product.price.toInt()}",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            Text(
              "${basketItem.amount.toInt()} с",
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (!isLast) ...[const SizedBox(height: 12), const DashedDivider()],
      ],
    );
  }
}
