import 'package:get/get_connect.dart';

class ApiClient {
  final GetConnect _getConnect;
  ApiClient._internal() : _getConnect = GetConnect() {
    // _getConnect.baseUrl = "https://www.baidu.com";
    _getConnect.baseUrl = "http://10.34.133.150:8000";
  }
  static final ApiClient _instance = ApiClient._internal();
  static ApiClient get instance => _instance;

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    final response = await _getConnect.get(path, query: query);
    return _handleResponse(response);
  }

  Future<Response> post(String path, {dynamic data}) async {
    final response = await _getConnect.post(path, data);
    return _handleResponse(response);
  }

  Future<Response> _handleResponse(Response response) async {
    if (response.status.hasError) {
      throw 'Error: ${response.statusText}';
    } else {
      return response;
    }
  }
}
