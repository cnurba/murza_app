import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:murza_app/app/clients/domain/models/client_model.dart';
import 'package:murza_app/app/clients/domain/repositories/i_client_repository.dart';
import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/app/products/domain/repositories/i_product_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/core/failure/auth_failure.dart';
import 'package:murza_app/core/failure/status_code.dart';
import 'package:murza_app/core/http/endpoints.dart';
import 'package:murza_app/core/http/handle_failure.dart';

class ClientRepository implements IClientRepository {
  final Dio _dio;

  const ClientRepository(this._dio);

  @override
  Future<ApiResult> getClients() async {
    return await handleFailure<ApiResult>(() async {
      log("START GET CLIENTS ");
      final responseData = await _dio.get(Endpoints.client.clients);
      final clients = (responseData.data as List)
          .map((clients) => ClientModel.fromJson(clients))
          .toList();
      log("FINISH CLIENTS length  ${clients.length}");
      return ApiResultWithData<List<ClientModel>>(data: clients);
    });
  }

  @override
  Future<ApiResult> newClient(ClientModel clientModel) async {
    try {
      log("START CREATE NEW CLIENT");
      final data = clientModel.toJson();
      final responseData = await _dio.post(
        Endpoints.client.clients,
        data: data,
      );
      log("FINISH NEW CLIENT");
      return ApiResultWithData(data: true);
    } catch (e) {
      log("Error validating client model: $e");
      return ApiResultFailureClient(message: "Ошибка валидации клиента");
    }
  }
}
