import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_provider.dart';
import 'package:murza_app/app/orders/presentation/basket/widgets/basket_card.dart';
import 'package:murza_app/app/orders/presentation/basket/basket_screen.dart';
import 'package:murza_app/app/orders/presentation/order/checkout_order_screen.dart';
import 'package:murza_app/app/products/presentation/widgets/product_card.dart';
import 'package:murza_app/core/extensions/router_extension.dart';
import 'package:murza_app/core/presentation/global/loader.dart';
import 'package:murza_app/core/presentation/messages/show_center_message.dart';
import '../application/products_by_brand_id.dart';

class ProductScreen extends ConsumerWidget {
  final int brandId;

  const ProductScreen({super.key, required this.brandId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListAsyncValue = ref.watch(
      productListByBrandIdFutureProvider(brandId),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            ref.read(basketProvider.notifier).clearSelectedProducts();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: productListAsyncValue.when(
        data: (products) {
          return Stack(
            children: [
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: 2, // spacing between rows
                  crossAxisSpacing: 2, // spacing between columns
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    onQuantityChanged: (quantity) {
                      ref
                          .read(basketProvider.notifier)
                          .addProduct(product, quantity);
                    },
                  );
                },
              ),
              Positioned(
                bottom: 100,
                right: 20,
                child: BasketCard(
                  onTap: () {
                    /// open basket screen by showBottomSheet
                    showBottomBasketSheet(context);
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stack) {
          showCenteredErrorMessage(context, error.toString());
          return SizedBox.shrink();
        },
        loading: () => Loader(),
      ),
    );
  }

  void showBottomBasketSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Material(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: FractionallySizedBox(heightFactor: 0.85, child: BasketScreen()),
        );
      },
    );
    if (result) {
      context.push(CheckoutOrderScreen());
      // Handle the result if needed
    }
  }
}
