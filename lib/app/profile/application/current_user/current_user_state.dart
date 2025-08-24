import 'package:equatable/equatable.dart';
import 'package:murza_app/app/profile/domain/models/user_model.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';

class CurrentUserState extends Equatable {
  final UserModel user;
  final BlocStateType stateType;
  final String? errorMessage;

  const CurrentUserState({
    required this.user,
    required this.stateType,
    this.errorMessage,
  });

 copyWith({
    UserModel? user,
    BlocStateType? stateType,
    String? errorMessage,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      stateType: stateType ?? this.stateType,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory CurrentUserState.initial() {
    return CurrentUserState(
      user: UserModel.empty(),
      stateType: BlocStateType.initial,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [user, stateType, errorMessage];
}
