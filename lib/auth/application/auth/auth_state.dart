part of 'auth_controller.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() authenticated,
    required R Function() unauthenticated,
  }) {
    if (this is AuthInitial) {
      return initial();
    } else if (this is AuthLoading) {
      return loading();
    } else if (this is AuthAuthenticated) {
      return authenticated();
    } else if (this is AuthUnAuthenticated) {
      return unauthenticated();
    }
    throw Exception('Unknown AuthState');
  }
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

final class AuthUnAuthenticated extends AuthState {}
