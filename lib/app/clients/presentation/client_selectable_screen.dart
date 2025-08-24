import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/clients/application/clients/clients_future_provider.dart';
import 'package:murza_app/core/failure/app_result.dart';

class ClientSelectableScreen extends ConsumerStatefulWidget {
  const ClientSelectableScreen({super.key});

  @override
  ConsumerState<ClientSelectableScreen> createState() => _ClientSelectableScreenState();
}

class _ClientSelectableScreenState extends ConsumerState<ClientSelectableScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() => _isSearching = true);
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(clientsFutureProvider);
    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: clientsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Ошибка загрузки клиентов')),
              data: (apiResult) {
                if (apiResult is ApiResultWithData<List<ClientModel>>) {
                  final clients = apiResult.data;
                  final filtered = _searchQuery.isEmpty
                      ? clients
                      : clients.where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
                  if (filtered.isEmpty) {
                    return const Center(child: Text('Клиенты не найдены'));
                  }
                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final client = filtered[index];
                      return ListTile(
                        title: Text(client.name),
                        subtitle: Text(client.phone),
                        onTap: () => Navigator.pop(context, client),
                        leading: const Icon(Icons.person_outline),
                        trailing: client.isWholesaler
                            ? const Chip(label: Text('Опт', style: TextStyle(fontSize: 10)))
                            : null,
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Ошибка получения данных'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            if (_isSearching)
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: TextField(
                    key: const ValueKey('searchField'),
                    controller: _searchController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Поиск клиента...',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
              )
            else
              const Expanded(
                child: Text(
                  'Выберите клиента',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.green),
              onPressed: _isSearching ? _stopSearch : _startSearch,
            ),
          ],
        ),
      ),
    );
  }
}

//Для вызова:
// showModalBottomSheet<ClientModel>(
//   context: context,
//   isScrollControlled: true,
//   builder: (_) => SizedBox(
//     height: MediaQuery.of(context).size.height * 0.85,
//     child: ClientSelectableScreen(),
//   ),
//);

