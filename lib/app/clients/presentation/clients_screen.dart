import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/application/clients/clients_future_provider.dart';
import 'package:murza_app/app/clients/application/new_client/new_client_provider.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/clients/presentation/new_client.dart';
import 'package:murza_app/app/clients/presentation/widgets/client_card.dart';
import 'package:murza_app/core/extensions/router_extension.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/presentation/global/loader.dart';
import 'package:murza_app/core/presentation/messages/show_center_message.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key, this.onClientSelected});

  final Function(ClientModel)? onClientSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsyncValue = ref.watch(clientsFutureProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Клиенты', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket, color: Colors.green),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showClientFormBottomSheet(context, (client) {
            ref.read(newClientProvider.notifier).postNewClient(client);
          });
        },
        child: Icon(Icons.add),
      ),
      body: clientsAsyncValue.when(
        data: (apiResult) {
          if (apiResult is ApiResultWithData) {
            return ListView.builder(
              itemCount: apiResult.data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    if (onClientSelected == null) {
                      return;
                    }
                    onClientSelected!(apiResult.data[index]);
                    context.pop();
                  },
                  child: ClientCard(
                    client: apiResult.data[index],
                    showButtons: true,
                    onTap: () {
                      if (onClientSelected == null) {
                        return;
                      }
                      onClientSelected!(apiResult.data[index]);
                    },
                  ),
                );
              },
            );

            //   GridView.builder(
            //   physics: const BouncingScrollPhysics(),
            //   padding: const EdgeInsets.all(8),
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 1, // number of items in each row
            //     mainAxisSpacing: 2, // spacing between rows
            //     crossAxisSpacing: 1, // spacing between columns
            //     childAspectRatio: 1.4,
            //   ),
            //   itemCount: apiResult.data.length,
            //   itemBuilder: (context, index) {
            //     final client = apiResult.data[index];
            //     return ClientCard(client: client, showButtons: true);
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
