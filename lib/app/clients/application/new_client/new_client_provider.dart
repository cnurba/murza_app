import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/application/clients/clients_future_provider.dart';
import 'package:murza_app/app/clients/application/new_client/new_client_controller.dart';
import 'package:murza_app/app/clients/application/new_client/new_client_state.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/clients/domain/repositories/i_client_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/injection.dart';

// final clientsFutureProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
//   final clientRepository = ref.watch(clientsRepositoryProvider);
//   final result = await clientRepository.newClient(clientModel);
//   return result;
// });

final newClientProvider = StateNotifierProvider<NewClientController, NewClientState>(
      (ref) => NewClientController(getIt<IClientRepository>()),
);
