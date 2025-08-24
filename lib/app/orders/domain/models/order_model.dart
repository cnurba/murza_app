import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int id;
  final int clientId;
  final int createdById;
  final String status;
  final DateTime deliveryDate;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderModel({
    required this.id,
    required this.clientId,
    required this.createdById,
    required this.status,
    required this.deliveryDate,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      clientId: json['client_id'] as int,
      createdById: json['created_by_id'] as int,
      status: json['status'] as String,
      deliveryDate: DateTime.parse(json['delivery_date'] as String),
      totalAmount: (json['total_amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
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
        createdAt,
        updatedAt,
      ];
}
