import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_item_state.dart';

class BasketState {
  final List<BasketItemState> products;
  final ClientModel client;
  final String? errorMessage;

  const BasketState({
    required this.products,
    required this.client,
    this.errorMessage,
  });
  factory BasketState.initial() {
    return BasketState(
      products: [],
      client: ClientModel.empty(),
      errorMessage: null,
    );
  }
  BasketState copyWith({
    List<BasketItemState>? products,
    ClientModel? client,
    String? errorMessage,
  }) {
    return BasketState(
      products: products ?? this.products,
      client: client ?? this.client,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}