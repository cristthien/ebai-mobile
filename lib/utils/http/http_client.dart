import 'dart:convert'; // For json.encode and json.decode
import 'package:http/http.dart' as http; // Alias http for the http package

class THttpHelper {
  static const String _baseUrl =
      'http://192.168.20.166:3000/api/v1';

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  /// Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final body = json.decode(response.body);
    // Dù HTTP trả về 200/201, nếu body chứa statusCode >= 400 thì đó là lỗi
    if (body['statusCode'] != null && body['statusCode'] >= 400) {
      final errorMessage = body['message'] ?? 'Unknown error occurred';
      throw Exception(errorMessage);
    }
    return body;
  }
}
