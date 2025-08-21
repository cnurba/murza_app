import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_item_state.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_state.dart';
import 'package:murza_app/app/products/domain/models/product.dart';

class BasketController
    extends StateNotifier<BasketState> {
  /// Creates a NewOrderController with an initial state.
  BasketController() : super((BasketState.initial()));

  /// Login function with _api.
  Future<void> addProduct(Product product, int count) async {


    /// Check if the product already exists in the state
    /// If it exists, update the count and amount
    /// If it does not exist, add it to the state
    final existingProductIndex = state.products.indexWhere(
      (s) => s.product.id == product.id,
    );
    if (existingProductIndex != -1) {
      // Product already exists, update the count and amount
      final existingProduct = state.products[existingProductIndex];

      bool isAdd = true;
      if (existingProduct.count > count) {
        isAdd = false;
      }

      final updatedProduct = existingProduct.copyWith(
        count: isAdd ? existingProduct.count + 1 : existingProduct.count - 1,
        amount: isAdd
            ? existingProduct.amount + (product.price * 1)
            : existingProduct.amount - (product.price * 1),
      );
      final newProductsItem = [
        ...state.products.sublist(0, existingProductIndex),
        updatedProduct,
        ...state.products.sublist(existingProductIndex + 1),
      ];

      state = state.copyWith(products: newProductsItem);

      /// if summ of all products is 0, remove the product from the state
      if (updatedProduct.count <= 0) {
        log("Removing product with id: ${product.id} as count is zero");
        final newProducts = [
          ...state.products.sublist(0, existingProductIndex),
          ...state.products.sublist(existingProductIndex + 1),
        ];

        state = state.copyWith(products: newProducts);
      }
    } else {
      BasketItemState basketItem =  BasketItemState(
        product: product,
        count: count,
        amount: product.price * count,
      );
      /// add the product to the state
      state = state.copyWith(
        products: [...state.products, basketItem],
      );
      log("Adding new product with id: ${product.id} to the basket");

    }
  }

  void clearSelectedProducts() {
    log("Clearing selected products");
    state = state.copyWith(products: []);
  }

  void removeProduct(int productId) {
    log("Removing product with id: $productId");
    /// remove the product with the given id from the state
    state = state.copyWith(
      products: state.products.where((s) => s.product.id != productId).toList(),
    );

  }

  void setClient(ClientModel selectedClient) {
    log("Setting client: ${selectedClient.name}");
    /// set the client in the state
    state = state.copyWith(client: selectedClient);
  }
}
