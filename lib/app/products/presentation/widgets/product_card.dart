import 'package:flutter/material.dart';
import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/core/presentation/image/cached_image.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function(int quantity)? onQuantityChanged;

  const ProductCard({super.key, required this.product, this.onQuantityChanged});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
    if (widget.onQuantityChanged != null) {
      widget.onQuantityChanged!(quantity);
    }
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
      if (widget.onQuantityChanged != null) {
        widget.onQuantityChanged!(quantity);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Фото + иконка лайка
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: CachedImage(
                  width: 200,
                  height: 120,
                  fit: BoxFit.cover,
                  imageUrl: widget.product.imageUrl,
                ), //product.images.first.photoUrl"),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),

          // Контент: цена, текст, плюс
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.product.price} с',
                  style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 40,
                  child: Text(
                    widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleButton(isAddButton: false,isVisible: quantity>0, onTap: decrementQuantity),
                    Visibility(
                      visible: quantity >0,
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    CircleButton(onTap: incrementQuantity),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, this.onTap, this.isAddButton = true, this.isVisible = true});

  final VoidCallback? onTap;
  final bool isAddButton;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isAddButton ? Icons.add : Icons.remove,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
