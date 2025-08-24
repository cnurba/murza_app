import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/profile/application/current_user/current_user_controller.dart';
import 'package:murza_app/app/profile/application/current_user/current_user_state.dart';
import 'package:murza_app/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:murza_app/injection.dart';

final currentUserProvider =
    StateNotifierProvider<CurrentUserController, CurrentUserState>(
      (ref) => CurrentUserController(getIt<IProfileRepository>()),
    );
