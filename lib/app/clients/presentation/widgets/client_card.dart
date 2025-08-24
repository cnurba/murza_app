import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientCard extends StatelessWidget {
  final ClientModel client;
  final bool showButtons;
  final Function()? onTap;

  const ClientCard({
    super.key,
    required this.client,
    this.showButtons = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap;
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client.name,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildRow(Icons.storefront, 'Market: ${client.marketName}'),
              _buildRow(
                Icons.confirmation_number,
                'Booth: ${client.boothNumber}',
              ),
              _buildRow(Icons.email, client.email),
              _buildRow(Icons.phone, client.phone),
              // if (showButtons) const SizedBox(height: 12),
              // if (showButtons)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       IconButton(
              //         onPressed: () => _callPhone(client.phone),
              //         icon: const Icon(
              //           CupertinoIcons.pencil_slash,
              //           color: Colors.red,
              //         ),
              //       ),
              //
              //       IconButton(
              //         onPressed: () => _callPhone(client.phone),
              //         icon: const Icon(CupertinoIcons.pen, color: Colors.green),
              //       ),
              //       const SizedBox(width: 8),
              //       Spacer(),
              //       IconButton(
              //         onPressed: () => _callPhone(client.phone),
              //         icon: const Icon(CupertinoIcons.heart, color: Colors.red),
              //       ),
              //
              //       // OutlinedButton.icon(
              //       //   onPressed: () => _callPhone(client.phone),
              //       //   icon: const Icon(Icons.phone),
              //       //   label: const Text("Позвонить"),
              //       // ),
              //       // const SizedBox(width: 8),
              //       // OutlinedButton.icon(
              //       //   onPressed: () => _sendEmail(client.email),
              //       //   icon: const Icon(Icons.email),
              //       //   label: const Text("Написать"),
              //       // ),
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  void _callPhone(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _sendEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
