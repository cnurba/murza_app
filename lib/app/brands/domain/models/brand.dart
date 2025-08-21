import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final String name;
  final int id;
  final String logoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Brand({
    required this.name,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.logoUrl,
  });

  factory Brand.initial() {
    return Brand(
      name: '',
      id: 0,
      logoUrl: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['name'] ??'',
      logoUrl: json['logo_url'] ?? '',
      id: json['id'] ??0,
      createdAt: DateTime.parse(json['created_at'] ??''),
      updatedAt: DateTime.parse(json['updated_at'] ??""),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'logo_url': logoUrl,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [name, id, createdAt, updatedAt, logoUrl];
}
