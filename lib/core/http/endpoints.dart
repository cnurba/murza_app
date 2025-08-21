import 'package:murza_app/core/http/server_address.dart';

final String _baseUrl = ServerAddress().baseUrl;

/// Defines endpoints for authentication.
class _Auth {
  String get login => "$_baseUrl/auth/signin";

  String get refresh => "$_baseUrl/auth/refresh-token";

  String get currentUser => "$_baseUrl/auth/whoami";
}

class _Product {
  String get products => "$_baseUrl/products/products/";

  String productsByBrandId(brandId) {
    return "$_baseUrl/products/brand/$brandId";
  }
}

class _Clients {
  String get clients => "$_baseUrl/clients/";
}

class _Brand {
  String get brands => "$_baseUrl/brands/";
}

/// Defines endpoints for connection to server.
class Endpoints {
  static get product => _Product();

  static get client => _Clients();

  static get auth => _Auth();

  static get brand => _Brand();

  static String get image => "$_baseUrl";
}
