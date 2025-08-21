import 'package:equatable/equatable.dart';

class NewLoginState extends Equatable {
  final String username;
  final String password;
  final bool checkingMode;

  const NewLoginState({
    required this.username,
    required this.password,
    this.checkingMode = false,

  });

  factory NewLoginState.initial() {
    return const NewLoginState(
      username: '',
      password: '',
    );
  }

  NewLoginState copyWith({
    String? username,
    String? password,
    bool? checkingMode,
  }) {
    return NewLoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      checkingMode: checkingMode ?? this.checkingMode,
    );
  }

  @override
  List<Object?> get props => [
    username,
    password,
    checkingMode,
  ];

}