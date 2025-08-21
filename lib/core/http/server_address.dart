/// Defines base endpoints for connection to server.
class ServerAddress {
  ///  Base address for connection.
  /// Test server
  //final String _address = "https://test-muras.maksnurgazy.com/muras/api";

  /// Product server
  final String _address = "http://212.112.99.42:8004";

  /// Api version.
  final String _apiVer = "";

  /// Base url for connection.
  //String get baseUrl => "$_address/$_apiVer";
  String get baseUrl => "$_address";

}
