
import '../../features/personalization/models/category_model.dart';
import '../../features/personalization/models/short_product_management_model.dart';
import '../../features/shop/models/product_model.dart';
import '../../features/shop/models/short_product_model.dart';
import '../../utils/http/http_client.dart';

class TCategoryService {
  // Define API endpoints
  static const String _getAllCategoriesEndpoint = 'categories'; // Example endpoint for fetching all products
  Future<List<CategoryModel>> getCategoriesList() async {
    try {
      // Send GET request using helper
      final Map<String, dynamic> responseData = await THttpHelper.get(_getAllCategoriesEndpoint);
      if (responseData['data'] is List) {
        final List<dynamic> categoryListJson = responseData['data'];
        final List<CategoryModel> cateogories = categoryListJson
            .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return cateogories;
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
}
