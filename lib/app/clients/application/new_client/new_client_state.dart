import 'package:equatable/equatable.dart';
import 'package:murza_app/core/enum/bloc_state_type.dart';

class NewClientState extends Equatable{
  final BlocStateType stateType;
  final String message;

  const NewClientState({
    this.stateType = BlocStateType.initial,
    this.message='',
  });

  factory NewClientState.initial() {
    return const NewClientState(
      stateType: BlocStateType.initial,
      message: '',
    );
  }

  NewClientState copyWith({
    BlocStateType? stateType,
    String? message,
  }) {
    return NewClientState(
      stateType: stateType ?? this.stateType,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [stateType, message];
}