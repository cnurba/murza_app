import 'package:equatable/equatable.dart';

class ProductImage extends Equatable {
  final int id;
  final int productId;
  final String photoUrl;
  final String alt;
  final String createdAt;

  const ProductImage({
    required this.id,
    required this.productId,
    required this.photoUrl,
    required this.alt,
    required this.createdAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id']??"",
      productId: json['product_id']??"",
      photoUrl: json['photo_url']??"",
      alt: json['alt']??"",
      createdAt: "",
    );
  }

  @override
  List<Object?> get props => [id, productId, photoUrl, alt, createdAt];


}