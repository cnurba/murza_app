import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/profile/application/current_user/current_user_state.dart';
import 'package:murza_app/app/profile/domain/models/user_model.dart';
import 'package:murza_app/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';
import 'package:murza_app/core/failure/app_result.dart';

class CurrentUserController extends StateNotifier<CurrentUserState> {
  /// Creates a CurrentUserController with an initial state.
  CurrentUserController(this._api) : super(CurrentUserState.initial());

  final IProfileRepository _api;

  get user => state.user;

  get isEmpty => state.user == UserModel.empty();

  void loadCurrentUser() async {
    state = state.copyWith(stateType: BlocStateType.loading);
    final user = await _api.getCurrentUser();
    if (user is ApiResultWithData<UserModel>) {
      setCurrentUser(user.data);
      state = state.copyWith(stateType: BlocStateType.loaded);
    } else {
      state = state.copyWith(stateType: BlocStateType.error);
    }
  }

  /// Sets the current user ID.
  void setCurrentUser(UserModel user) {
    state = state.copyWith(user: user);
  }
}
