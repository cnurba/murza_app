import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/application/new_client/new_client_state.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/clients/domain/repositories/i_client_repository.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';

class NewClientController extends StateNotifier<NewClientState> {
  NewClientController(this._api) : super((NewClientState.initial()));

  final IClientRepository _api;

  /// Post new client function with _api.
  Future<void> postNewClient(ClientModel clientModel) async {
    state = state.copyWith(stateType: BlocStateType.loading);

    final result = await _api.newClient(clientModel);
    result.fold(
      (failure) {
        state = state.copyWith(stateType: BlocStateType.error, message: "");
      },
      (success) {
        state = state.copyWith(
          stateType: BlocStateType.loaded,
          message: "Клиент успешно добавлен",
        );
      },
    );
  }
}
