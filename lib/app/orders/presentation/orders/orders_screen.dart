import 'package:flutter/material.dart';
import 'package:murza_app/app/products/presentation/widgets/product_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket, color: Colors.green),
          ),
        ],
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 2, // spacing between rows
          crossAxisSpacing: 2, // spacing between columns
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return Text("1");
        },
      ),
    );
  }
}
