import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String access;
  final String refresh;

  const Token({
    required this.access,
    required this.refresh,
  });

  factory Token.empty() => const Token(access: "", refresh: "");

  Token copyWith({
    String? access,
    String? refresh,
  }) {
    return Token(
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': access,
      'refresh_token': refresh,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      access: map['access_token'] ?? "",
      refresh: map['refresh_token'] ?? "",
    );
  }

  @override
  List<Object?> get props => [
        access,
        refresh,
      ];
}
