import 'package:murza_app/auth/domain/models/token.dart';

/// Describe method of secure storage.
abstract class ISecureStorage {
  /// Get token.
  Future<Token?> read();

  /// Save token.
  Future<void> save(Token token);

  /// Clear storage.
  Future<void> clear();
}
