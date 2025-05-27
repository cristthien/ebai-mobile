
import '../../features/personalization/models/order_model.dart';
import '../../utils/http/http_client.dart'; // Import your HTTP helper

class TOrderService {
  // Define API endpoint for orders
  static const String _getAllOrdersEndpoint = 'invoices'; // <--- Adjust this to your actual API endpoint for fetching orders/invoices
  final String _patchInvoiceEndpoint = 'invoices';
  /// Fetches a list of orders for the current user.
  /// Replace 'orders' with your actual API endpoint if it's different (e.g., 'invoices').
  /// You might need to pass a user ID or authentication token.
  Future<List<OrderModel>> getOrdersList() async {
    try {
      // Send GET request using the helper
      final Map<String, dynamic> responseData = await THttpHelper.get(_getAllOrdersEndpoint);

      // Check if 'data' field exists and is a List
      if (responseData['data']['data'] is List) {
        final List<dynamic> orderListJson = responseData['data']['data'];
        final List<OrderModel> orders = orderListJson
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return orders;
      } else {
        // If 'data' is not a List or is missing, throw an error
        throw Exception('Invalid data format received for orders. Expected a list in "data" field.');
      }
    } catch (e) {
      // Catch error, print a more detailed error message
      print('Error during fetching orders: $e');
      // Rethrow the error so that the calling code can handle it
      rethrow; // Preserve the original error's stack trace
    }
  }
  Future<Map<String, dynamic>> updateInvoiceDetails({
    required String invoiceId, // ID hóa đơn có thể là String hoặc int tùy API của bạn
    required String address,
    required String phoneNumber,
  }) async {
    try {
      final String endpoint = '$_patchInvoiceEndpoint/$invoiceId'; // Xây dựng endpoint
      final Map<String, dynamic> data = {
        'address': address,
        'phoneNumber': phoneNumber,
        // Thêm các trường khác nếu bạn muốn cập nhật trong invoice
      };

      print('Sending PATCH request to $endpoint with data: $data'); // Để debug

      // Gọi phương thức patch từ THttpHelper
      final Map<String, dynamic> response = await THttpHelper.patch(endpoint, data);

      print('API response for invoice update: $response'); // Để debug
      return response;
    } catch (e) {
      print('Error updating invoice details: $e');
      rethrow; // Báo lỗi cho lớp gọi
    }
  }

// You can add more order-related API calls here, for example:
// Future<OrderModel> getOrderById(String orderId) async { ... }
// Future<void> createOrder(Map<String, dynamic> orderData) async { ... }
}