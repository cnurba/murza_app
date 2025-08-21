import 'package:flutter/material.dart';
import 'package:murza_app/app/brands/domain/models/brand.dart';
import 'package:murza_app/core/presentation/image/cached_image.dart';

class BrandCard extends StatelessWidget {
  final Brand brand;
  final VoidCallback onTap;

  const BrandCard({super.key, required this.brand, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Row(
          children: [
            CachedImage(
              imageUrl: brand.logoUrl,
              width: 100,
              height: 80,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(12),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                brand.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
