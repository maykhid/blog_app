import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/error/exception.dart';

class APIService {
  /// GET request
  Future<http.Response> get(
      {required Uri url, Map<String, String>? headers}) async {
    final response =
        await http.get(url, headers: headers ?? {}).catchError((_) {
      throw ServerException('Connection Error: Check your internet connection', 0);
    });
    return _handleResponse(response);
  }

  /// POST request
  Future<http.Response> post({
    required Uri url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await http
        .post(url, headers: headers ?? {}, body: json.encode(body ?? {}))
        .catchError((_) {
      throw ServerException('Connection Error', 0);
    });
    return _handleResponse(response);
  }

  /// Handle response
  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response;
    }
    final errorBody = jsonDecode(response.body);
    throw ServerException(errorBody, response.statusCode);
  }
}
