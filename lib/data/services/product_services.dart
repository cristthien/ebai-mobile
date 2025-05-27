
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../features/personalization/models/short_product_management_model.dart';
import '../../features/shop/models/product_model.dart';
import '../../features/shop/models/short_product_model.dart';
import '../../utils/http/http_client.dart';

/// A service class for handling product-related API calls.
class TProductService {
  // Define API endpoints
  static const String _getNewListingProductsEndpoint = 'auctions/new-listing'; // Example endpoint for fetching all products
  static const String _getExploreByIdEndpoint = 'auctions/'; // Example endpoint for fetching a single product by ID
  static const String _getAuctionsByUserIDEndpoint = 'auctions/user/-1'; // Example endpoint for fetching a single product by ID

  Future<List<ShortProductModel>> getNewListingProducts() async {
    try {
      // Send GET request using helper
      final Map<String, dynamic> responseData = await THttpHelper.get(_getNewListingProductsEndpoint);
      if (responseData['data'] is List) {
        final List<dynamic> productListJson = responseData['data'];
        final List<ShortProductModel> products = productListJson
            .map((json) => ShortProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception('Invalid data format received for products.');
      }
    } catch (e) {
      // Catch error, print more detailed error message
      print('Error during fetching all products: $e');
      // Rethrow the error so that the calling code can handle it (e.g., display an error message to the user)
      rethrow; // Use rethrow to preserve the original error's stack trace
    }
  }
  Future<ProductModel> getAuctionBySlug(String slug) async {
    try {
      // Construct the specific endpoint using the slug
      final String fullEndpoint = '$_getExploreByIdEndpoint$slug'; // auctions/explore/your-product-slug

      // Send GET request using helper
      final Map<String, dynamic> responseData = await THttpHelper.get(fullEndpoint);

      // Check if 'data' exists and is a Map
      if (responseData['data'] is Map<String, dynamic>) {
        final Map<String, dynamic> productJson = responseData['data'];
        final ProductModel product = ProductModel.fromJson(productJson);
        print('Successfully fetched product details for slug "$slug": $product');
        return product;
      } else {
        // Handle cases where 'data' might be null or not in the expected format
        throw Exception('Invalid data format received for product details (slug: $slug).');
      }
    } catch (e) {
      // Catch error, print more detailed error message
      print('Error during fetching product details for slug "$slug": $e');
      rethrow; // Re-throw the error for the calling code to handle
    }
  }
  Future<List<ShortProductManagementModel>> getAuctionsByUserID({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final String fullEndpoint = '$_getAuctionsByUserIDEndpoint?page=$page&limit=$limit';

      final Map<String, dynamic> responseData = await THttpHelper.get(fullEndpoint);
      print('Received response: $responseData');
      if (responseData['data']['data'] is List) {
        final List<dynamic> productJsonList = responseData['data']['data'];
        print('Received ${productJsonList} products for page $page, limit $limit.');
        final List<ShortProductManagementModel> products = productJsonList
            .map((json) => ShortProductManagementModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        // Xử lý trường hợp 'data' không phải là List hoặc không có
        throw Exception('Invalid data format received for user auctions. Expected a list under "data" key.');
      }
    } catch (e) {
      // Bắt lỗi và in ra thông báo chi tiết hơn
      print('Error during fetching user auctions: $e');
      rethrow; // Re-throw lỗi để code gọi hàm này có thể xử lý
    }
  }

}
