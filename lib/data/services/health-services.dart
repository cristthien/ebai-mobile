
import '../../utils/http/http_client.dart';

class HealthService {
  // Endpoint cụ thể cho việc kiểm tra sức khỏe database
  static const String _checkDbEndpoint = 'health/check-db';
  /// Hàm kiểm tra sức khỏe database
  Future<Map<String, dynamic>> checkDatabaseHealth() async {
    try {
      // Sử dụng THttpHelper để thực hiện GET request
      final responseData = await THttpHelper.get(_checkDbEndpoint);


      return responseData; // Trả về dữ liệu nhận được từ API
    } catch (e) {
      // Xử lý lỗi khi gọi API (ví dụ: in lỗi ra console hoặc ném lại lỗi)
      print('Error checking database health: $e');
      rethrow; // Ném lại lỗi để nơi gọi hàm này có thể xử lý
    }
  }
}