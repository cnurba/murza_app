import 'package:flutter/material.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_item_state.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_state.dart';
import 'package:murza_app/core/presentation/image/cached_image.dart';

class BasketItemCard extends StatefulWidget {
  final BasketItemState productState;
  final VoidCallback onDelete;
  final VoidCallback? onFavoriteToggle; // Optional
  final Function(int newQuantity) onQuantityChanged;

  const BasketItemCard({
    super.key,
    required this.productState,
    required this.onDelete,
    this.onFavoriteToggle,
    required this.onQuantityChanged,
  });

  @override
  _BasketItemCardState createState() => _BasketItemCardState();
}

class _BasketItemCardState extends State<BasketItemCard> {
  late int _quantity;
  bool _isFavorite = false; // Example state for favorite

  @override
  void initState() {
    super.initState();
    _quantity = widget.productState.count;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      widget.onQuantityChanged(_quantity);
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      // Or 0 if you allow removing by decrementing to zero
      setState(() {
        _quantity--;
        widget.onQuantityChanged(_quantity);
      });
    } else if (_quantity == 1) {
      // Optional: if quantity is 1 and user presses minus, delete item
      // widget.onDelete();
      // Or simply do nothing, or allow quantity to go to 0 if that's a valid state
      setState(() {
        _quantity--; // Allow going to 0, then perhaps onDelete logic fires if _quantity is 0
        widget.onQuantityChanged(_quantity);
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteToggle?.call();
  }

  double get _totalPrice => _quantity * widget.productState.product.price;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Image with Delete Icon
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child:
                      // Replace with your actual image loading
                      CachedImage(
                        imageUrl: widget.productState.product.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: widget.onDelete,
                      tooltip: 'Remove item',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            // Middle: Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Distribute space
                children: [
                  Text(
                    widget.productState.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.productState.product.description,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  // Give some space before the unit price
                  Text(
                    "${_quantity} X ${widget.productState.product.price.toStringAsFixed(0)} c",
                    // Assuming 'c' is currency
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Right: Price and Quantity Controls
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.onFavoriteToggle != null)
                  InkWell(
                    onTap: _toggleFavorite,
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      // Padding for better tap area
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.pink : Colors.grey[400],
                        size: 24,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 32),

                // Placeholder to maintain alignment if no favorite icon
                Text(
                  "${_totalPrice.toStringAsFixed(0)} c",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onPressed: _decrementQuantity,
                      enabled:
                          _quantity >
                          0, // Disable if quantity is 0, or 1 based on logic
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        _quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onPressed: _incrementQuantity,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(Icons.cake_outlined, color: Colors.grey[400], size: 40),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool enabled = true,
  }) {
    return Material(
      color: enabled ? Colors.purple : Colors.grey[400],
      shape: const CircleBorder(),
      elevation: enabled ? 1 : 0,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(6.0), // Adjusted padding
          child: Icon(
            icon,
            color: Colors.white,
            size: 20, // Adjusted size
          ),
        ),
      ),
    );
  }
}
