import 'package:murza_app/app/profile/domain/models/user_model.dart';

/// Describes the user information service.
abstract class IUserModelCache {
  /// Returns user profile.
  UserModel get userModel;

  /// Set user profile.
  ///
  /// `userProfile` User profile.
  void setUserModel(UserModel userModel);
}
