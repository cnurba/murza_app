import 'package:equatable/equatable.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';
import 'package:murza_app/core/failure/app_result.dart';

class LoginState extends Equatable {
  final BlocStateType stateType;
  final ApiResult? apiResult;

  const LoginState({this.stateType = BlocStateType.initial, this.apiResult});

  factory LoginState.initial() {
    return LoginState(
      stateType: BlocStateType.initial,
      apiResult: ApiResultInitial(),
    );
  }
  LoginState copyWith({BlocStateType? stateType, ApiResult? apiResult}) {
    return LoginState(
      stateType: stateType ?? this.stateType,
      apiResult: apiResult ?? this.apiResult,
    );
  }

  @override
  String toString() {
    return 'LoginState{stateType: $stateType, apiResult: $apiResult}';
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [stateType, apiResult];
}
