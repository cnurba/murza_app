import 'package:equatable/equatable.dart';

class OrderDetailModel extends Equatable {
  final int id;
  final int clientId;
  final int createdById;
  final String status;
  final DateTime deliveryDate;
  final double totalAmount;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItem> items;

  const OrderDetailModel({
    required this.id,
    required this.clientId,
    required this.createdById,
    required this.status,
    required this.deliveryDate,
    required this.totalAmount,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json['id'] as int,
      clientId: json['client_id'] ??0,
      createdById: json['created_by_id'] ??0,
      status: json['status'] ??"",
      deliveryDate: DateTime.parse(json['delivery_date'] ??''),
      totalAmount: (json['total_amount'] as num).toDouble()??0.0,
      comment: json['comment'] ??"",
      createdAt: DateTime.parse(json['created_at'] ??""),
      updatedAt: DateTime.parse(json['updated_at'] ??''),
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'created_by_id': createdById,
      'status': status,
      'delivery_date': deliveryDate.toIso8601String(),
      'total_amount': totalAmount,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        clientId,
        createdById,
        status,
        deliveryDate,
        totalAmount,
        comment,
        createdAt,
        updatedAt,
        items,
      ];
}

class OrderItem extends Equatable {
  final int id;
  final int productId;
  final double quantity;
  final double unitPrice;

  const OrderItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ??0,
      productId: json['product_id'] ??0,
      quantity: (json['quantity'] as num).toDouble() ??0,
      unitPrice: (json['unit_price'] as num).toDouble()??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'unit_price': unitPrice,
    };
  }

  // Метод для получения общей стоимости позиции
  double get totalPrice => quantity * unitPrice;

  @override
  List<Object?> get props => [id, productId, quantity, unitPrice];
}
