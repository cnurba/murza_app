import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/clients/presentation/client_selectable_screen.dart';
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
                showClientSelectionSheet(context, ref);
                //selectClient(context, ref);
              },
            );
          },
        ),
      ),
    );
  }

  showClientSelectionSheet(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet<ClientModel>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: ClientSelectableScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        _clientController.text = result.name;
      });
      // Assuming you have access to the WidgetRef here, you might need to pass it down or use another method to get it.
      ref.read(basketProvider.notifier).setClient(result);
    }
  }

  /// create a method to show a bottom sheet with the ClientsScreen
  /// on client selected, set the client in the basket provider and set the text in the text field
  /// close the bottom sheet
}
