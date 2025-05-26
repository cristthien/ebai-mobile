
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../features/shop/models/product_model.dart';
import '../../features/shop/models/short_product_model.dart';
import '../../utils/http/http_client.dart';

/// A service class for handling product-related API calls.
class TProductService {
  // Define API endpoints
  static const String _getNewListingProductsEndpoint = 'auctions/new-listing'; // Example endpoint for fetching all products
  static const String _getExploreByIdEndpoint = 'auctions/'; // Example endpoint for fetching a single product by ID

  Future<List<ShortProductModel>> getNewListingProducts() async {


    try {
      // Send GET request using helper
      final Map<String, dynamic> responseData = await THttpHelper.get(_getNewListingProductsEndpoint);

      if (responseData['data'] is List) {
        final List<dynamic> productListJson = responseData['data'];
        final List<ShortProductModel> products = productListJson
            .map((json) => ShortProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
        print('Successfully fetched products: $products');
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

}
