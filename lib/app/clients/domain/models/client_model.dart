import 'package:equatable/equatable.dart';

class ClientModel extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String inn;
  final String contactPerson;
  final String region;
  final String marketName;
  final String boothNumber;
  final bool isWholesaler;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ClientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.inn,
    required this.contactPerson,
    required this.region,
    required this.marketName,
    required this.boothNumber,
    required this.isWholesaler,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'] ??0 ,
      name: json['name'] ??"",
      phone: json['phone'] ??"",
      email: json['email'] ??"",
      inn: json['inn'] ??"",
      contactPerson: json['contact_person'] ??"",
      region: json['region'] ??"",
      marketName: json['market_name'] ??"",
      boothNumber: json['booth_number'] ??"",
      isWholesaler: json['is_wholesaler'] ?? false,
      notes: json['notes'] ??"",
      createdAt: DateTime.parse(json['created_at'] ??""),
      updatedAt: DateTime.parse(json['updated_at'] ??""),
    );
  }

  factory ClientModel.empty() {
    return ClientModel(
      id: 0,
      name: "",
      phone: "",
      email: "",
      inn: "",
      contactPerson: "",
      region: "",
      marketName: "",
      boothNumber: "",
      isWholesaler: false,
      notes: "",
      createdAt: DateTime.fromMillisecondsSinceEpoch(0), // Replace 'year' with a valid year, e.g., 2023
      updatedAt: DateTime(0),
    );
  }

  Map<String, dynamic> toJson() {
    return {

      'name': name,
      'phone': phone,
      'email': email,
      'inn': inn,
      'contact_person': contactPerson,
      'region': region,
      'market_name': marketName,
      'booth_number': boothNumber,
      'is_wholesaler': isWholesaler,
      'notes': notes,

    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    email,
    inn,
    contactPerson,
    region,
    marketName,
    boothNumber,
    isWholesaler,
    notes,
    createdAt,
    updatedAt,
  ];
}