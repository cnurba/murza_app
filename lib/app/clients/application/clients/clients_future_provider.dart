import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/clients/domain/repositories/i_client_repository.dart';
import 'package:murza_app/app/clients/infrastructure/repositories/client_repository.dart';
import 'package:murza_app/app/products/domain/models/product.dart';
import 'package:murza_app/app/products/domain/repositories/i_product_repository.dart';
import 'package:murza_app/app/products/infrastructure/repositories/product_repository.dart';
import 'package:murza_app/core/failure/app_result.dart';
import 'package:murza_app/injection.dart';

final clientsRepositoryProvider = Provider<IClientRepository>(
  (ref) => ClientRepository(getIt<Dio>()),
);

final clientsFutureProvider = FutureProvider.autoDispose<ApiResult>((
  ref,
) async {
  final clientRepository = ref.watch(clientsRepositoryProvider);
  final result = await clientRepository.getClients();
  return result;
});
