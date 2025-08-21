import 'package:equatable/equatable.dart';
import 'package:murza_app/app/products/domain/models/product.dart';

class BasketItemState extends Equatable {
  final Product product;
  final int count;
  final double amount;

  const BasketItemState({
    required this.product,
    required this.count,
    required this.amount,
  });

  factory BasketItemState.initial() {
    return BasketItemState(
      product: Product.empty(),
      count: 0,
      amount: 0.0,
    );
  }

  BasketItemState copyWith({
    Product? product,
    int? count,
    double? amount,
  }) {
    return BasketItemState(
      product: product ?? this.product,
      count: count ?? this.count,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [product, count, amount];
}
