import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/presentation/clients_screen.dart';
import 'package:murza_app/app/orders/application/basket_products/basket_provider.dart';
import 'package:murza_app/core/extensions/router_extension.dart';
import 'package:murza_app/core/presentation/textforms/client_text_field.dart';

class ClientSelectedWidget extends StatefulWidget {
  const ClientSelectedWidget({super.key});

  @override
  State<ClientSelectedWidget> createState() => _ClientSelectedWidgetState();
}

class _ClientSelectedWidgetState extends State<ClientSelectedWidget> {
  final TextEditingController _clientController = TextEditingController();

  @override
  void dispose() {
    _clientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: ClientTextField(
        controller: _clientController,
        labelText: "Клиент",
        onChanged: (value) {},
        isEnabled: false,
        suffixIcon: Consumer(
          builder: (context, ref, child) {
            return IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                _selectClient(context, ref);
              },
            );
          },
        ),
      ),
    );
  }

  void _selectClient(BuildContext context, WidgetRef ref) {
    context.push(
      ClientsScreen(
        onClientSelected: (selectedClient) {
          setState(() {
            // Update the client controller with the selected client's name
            _clientController.text = selectedClient.name;
          });
          // Update the client controller with the selected client's name
          _clientController.text = selectedClient.name;
          // Optionally, you can also update the state or provider with the selected client
          ref.read(basketProvider.notifier).setClient(selectedClient);
        },
      ),
    );
  }
}
