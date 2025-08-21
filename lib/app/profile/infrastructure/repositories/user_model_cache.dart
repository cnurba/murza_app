import 'package:murza_app/app/profile/domain/models/user_model.dart';
import 'package:murza_app/app/profile/domain/repositories/i_user_model_cache.dart';

class UserModelCache extends IUserModelCache {
  late UserModel _userModel;

  @override
  void setUserModel(UserModel userModel) {
    _userModel = userModel;
  }

  @override
  UserModel get userModel => _userModel;
}
