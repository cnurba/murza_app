import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/profile/domain/repositories/i_user_model_cache.dart';
import 'package:murza_app/auth/application/auth/auth_controller.dart';
import 'package:murza_app/auth/domain/repositories/i_auth_api_service.dart';
import 'package:murza_app/injection.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(getIt<IAuthApiService>(), getIt<IUserModelCache>()),
);
