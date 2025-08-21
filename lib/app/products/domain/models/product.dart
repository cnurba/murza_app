import 'package:equatable/equatable.dart';
import 'package:murza_app/app/brands/domain/models/brand.dart';
import 'package:murza_app/app/products/domain/models/product_image.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String article;
  final String description;
  final String fullDescription;
  final String videoUrl;
  final double price;
  final bool available;
  final String color;
  final String volumeLiters;
  final String consumption;
  final String dryingTimeTouch;
  final String dryingTimeFull;
  final String dryingTimeSecondLayer;
  final String dilution;
  final String baseTemp;
  final String primer;
  final String rollerType;
  final String country;
  final List<String> tags;
  final Brand brand;
  final List<ProductImage> images;
  final String createdAt;
  final String updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.article,
    required this.description,
    required this.fullDescription,
    required this.videoUrl,
    required this.price,
    required this.available,
    required this.color,
    required this.volumeLiters,
    required this.consumption,
    required this.dryingTimeTouch,
    required this.dryingTimeFull,
    required this.dryingTimeSecondLayer,
    required this.dilution,
    required this.baseTemp,
    required this.primer,
    required this.rollerType,
    required this.country,
    required this.tags,
    required this.brand,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']??"",
      name: json['name']??"",
      article: json['article']??'',
      description: json['description']??'',
      fullDescription: json['full_description']??'',
      videoUrl: json['video_url']?? '',
      price: json['price'] ?? 0.0 ,
      available: json['available']??'',
      color: json['color']??'',
      volumeLiters: json['volume_liters']??'',
      consumption: json['consumption'] ??'',
      dryingTimeTouch: json['drying_time_touch']??'',
      dryingTimeFull: json['drying_time_full']??'',
      dryingTimeSecondLayer: json['drying_time_second_layer']??'',
      dilution: json['dilution']??'',
      baseTemp: json['base_temp']??'',
      primer: json['primer']??'',
      rollerType: json['roller_type']??'',
      country: json['country'],
      tags: List<String>.from(json['tags']),
      brand: Brand.fromJson(json['brand']),
      images: (json['images'] as List)
          .map((image) => ProductImage.fromJson(image))
          .toList(),
      createdAt: json['createdAt']??'',
      updatedAt: json['updatedAt']??"",
    );
  }

  factory Product.empty() {
    return Product(
      id: 0,
      name: '',
      article: '',
      description: '',
      fullDescription: '',
      videoUrl: '',
      price: 0.0,
      available: false,
      color: '',
      volumeLiters: '',
      consumption: '',
      dryingTimeTouch: '',
      dryingTimeFull: '',
      dryingTimeSecondLayer: '',
      dilution: '',
      baseTemp: '',
      primer: '',
      rollerType: '',
      country: '',
      tags: const [],
      brand: Brand.initial(),
      images: const [],
      createdAt: '',
      updatedAt: '',
    );
  }

  get imageUrl {
    if (images.isNotEmpty) {
      return images.first.photoUrl;
    }
    return '';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    article,
    description,
    fullDescription,
    videoUrl,
    price,
    available,
    color,
    volumeLiters,
    consumption,
    dryingTimeTouch,
    dryingTimeFull,
    dryingTimeSecondLayer,
    dilution,
    baseTemp,
    primer,
    rollerType,
    country,
    tags,
    brand,
    images,
    createdAt,
    updatedAt,
  ];
}