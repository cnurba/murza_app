import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_controller.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_state.dart';

final basketProvider = StateNotifierProvider<BasketController, BasketState>(
      (ref) => BasketController(),
);
