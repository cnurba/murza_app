import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/brands/application/brands_future_provider.dart';
import 'package:murza_app/app/brands/presentation/brand_card.dart';
import 'package:murza_app/app/clients/application/clients/clients_future_provider.dart';
import 'package:murza_app/app/clients/application/new_client/new_client_provider.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/clients/presentation/new_client.dart';
import 'package:murza_app/app/products/presentation/product_screen.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/http/endpoints.dart';
import 'package:murza_app/core/presentation/global/loader.dart';
import 'package:murza_app/core/presentation/image/cached_image.dart';
import 'package:murza_app/core/presentation/messages/show_center_message.dart';

class BrandsScreen extends ConsumerWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsyncValue = ref.watch(brandsFutureProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Бренды', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket, color: Colors.green),
          ),
        ],
      ),

      body: brandsAsyncValue.when(
        data: (apiResult) {
          if (apiResult is ApiResultWithData) {
            return ListView.builder(
              itemCount: apiResult.data.length,
              itemBuilder: (context, index) {
              final brand = apiResult.data[index];
              return BrandCard(brand: brand,onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductScreen(brandId: brand.id),
                  ),
                );
              },);
            },);



            //   GridView.builder(
            //   physics: const BouncingScrollPhysics(),
            //   padding: const EdgeInsets.all(8),
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2, // number of items in each row
            //     mainAxisSpacing: 8, // spacing between rows
            //     crossAxisSpacing: 8, // spacing between columns
            //     childAspectRatio: 3,
            //   ),
            //   itemCount: apiResult.data.length,
            //   itemBuilder: (context, index) {
            //     final brand = apiResult.data[index];
            //     return BrandCard(brand: brand,onTap: () {
            //
            //     },);
            //   },
            // );
          } else if (apiResult is ApiResultFailureClient) {
            showCenteredErrorMessage(context, apiResult.message);
            return SizedBox.shrink();
          } else {
            return Center(child: Text('Unexpected result type'));
          }
        },
        error: (error, stack) {
          showCenteredErrorMessage(context, error.toString());
          return SizedBox.shrink();
        },
        loading: () => Loader(),
      ),
    );
  }
}

void showClientFormBottomSheet(
  BuildContext context,
  void Function(ClientModel) onSave,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    elevation: 3,
    backgroundColor: Colors.white,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.9,
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Expanded(child: ClientForm(onSave: onSave))],
        ),
      );
    },
  );
}
