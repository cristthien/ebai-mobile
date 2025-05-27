import 'dart:convert'; // For json.encode and json.decode
import 'package:http/http.dart' as http;

import '../../data/local_storage/local_storage.dart'; // Alias http for the http package

class THttpHelper {
  static const String _baseUrl =
      'http://172.16.1.147:3000/api/v1';

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final String? accessToken = await TLocalStorage().readData<String>('access_token'); // Lấy token
    // Tạo headers
    Map<String, String> headers = {
      'Content-Type': 'application/json', // Thường là JSON cho API
      'Accept': 'application/json', // Thường là JSON cho API
    };
    // Nếu có accessToken, thêm Authorization header
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers, // <-- Thêm headers vào đây
    );
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
      String endpoint,
      dynamic data,
      ) async {
    final String? token = await TLocalStorage().readData<String>('access_token');

    // Khởi tạo headers mặc định
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Thêm Authorization header nếu có token
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token'; // <--- Thêm header xác thực
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers, // <--- Sử dụng headers đã được cập nhật
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
  static Future<Map<String, dynamic>> postMultipart(
      String endpoint, Map<String, String> fields, List<http.MultipartFile> files) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/$endpoint'));

      final String? token = await TLocalStorage().readData<String>('access_token'); // <-- Lấy access_token
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token'; // <-- Thêm Authorization header
      }
      // Thêm các trường văn bản
      request.fields.addAll(fields);

      // Thêm các file
      request.files.addAll(files);

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      // Chuyển đổi StreamedResponse thành http.Response để xử lý thống nhất
      final http.Response httpResponse = http.Response(
        responseBody,
        streamedResponse.statusCode,
        headers: streamedResponse.headers,
      );

      return _handleResponse(httpResponse);
    } catch (e) {
      print('HTTP POST Multipart Error for $endpoint: $e');
      throw Exception('Failed to send data. Please try again.');
    }
  }
  /// Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }
  static Future<Map<String, dynamic>> patch(
      String endpoint,
      dynamic data,
      ) async {
    final String? token = await TLocalStorage().readData<String>('access_token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.patch( // <-- Sử dụng http.patch
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers,
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final body = json.decode(response.body);
    if (body['statusCode'] != null && body['statusCode'] >= 400) {
      final errorMessage = body['message'] ?? 'Unknown error occurred';
      throw Exception(errorMessage);
    }
    return body;
  }
}
