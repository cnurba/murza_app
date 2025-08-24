import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String username;
  final bool isActive;
  final String name;
  final String surname;
  final String lastname;
  final String phone;
  final String whatsapp;
  final String email;
  final String address;
  final String city;
  final String state;
  final String country;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.username,
    required this.isActive,
    required this.name,
    required this.surname,
    required this.lastname,
    required this.phone,
    required this.whatsapp,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.empty() {
    return UserModel(
      id: 0,
      username: "",
      isActive: false,
      name: "",
      surname: '',
      lastname: "",
      phone: '',
      whatsapp: "",
      email: '',
      address: "",
      city: "",
      state: "",
      country: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Factory constructor to create a UserModel from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ??0,
      username: json['username'] ?? "",
      isActive: json['is_active'] ?? false,
      name: json['name'] ??"",
      surname: json['surname'] ??'',
      lastname: json['lastname'] ??"",
      phone: json['phone'] ??'',
      whatsapp: json['whatsapp'] ??"",
      email: json['email'] ?? '',
      address: json['address'] ??"",
      city: json['city'] ??"",
      state: json['state'] ??"",
      country: json['country'] ??'',
      createdAt: DateTime.parse(json['created_at']??'1970-01-01T00:00:00Z'),
      updatedAt: DateTime.parse(json['updated_at']??'1970-01-01T00:00:00Z'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'is_active': isActive,
      'name': name,
      'surname': surname,
      'lastname': lastname,
      'phone': phone,
      'whatsapp': whatsapp,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    username,
    isActive,
    name,
    surname,
    lastname,
    phone,
    whatsapp,
    email,
    address,
    city,
    state,
    country,
    createdAt,
    updatedAt,
  ];
}