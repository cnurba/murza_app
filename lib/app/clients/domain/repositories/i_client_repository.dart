import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/failure/auth_failure.dart';

import '../models/client_model.dart';

abstract class IClientRepository {
  Future<ApiResult> getClients();
  Future<ApiResult> newClient(ClientModel clientModel);
}
