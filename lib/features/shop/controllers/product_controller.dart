import 'package:get/get.dart';

import '../../../data/services/product_services.dart';
import '../../../utils/popups/loaders.dart';
import '../models/short_product_model.dart'; // Assuming GetX is used for state management
/// A controller class for managing product-related logic and state.
class ProductController extends GetxController {
  /// Singleton instance of ProductController.
  static ProductController get instance => Get.find();

  /// Observable boolean to indicate if products are currently loading.
  final isLoading = false.obs;


  /// Observable list of featured products.
  // Uncomment and adjust the import for ProductModel if you have one
  RxList<ShortProductModel> featuredProducts = <ShortProductModel>[].obs;

  final product_service = TProductService();
  /// Called when the controller is initialized.
  /// Fetches featured products upon initialization.
  @override
  void onInit() {
    fetchNewListingProducts();
    super.onInit();
  }

  /// Fetches featured products from the repository.
  /// Shows a loader while fetching and handles errors.
  void fetchNewListingProducts() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Products
      // Uncomment the line below and ensure productRepository and ProductModel are correctly imported
      final products = await product_service.getNewListingProducts();

      // Assign Products
      // Uncomment and assign the fetched products to featuredProducts
      featuredProducts.assignAll(products);

    } catch (e) {
      // Catch error and display a snackbar message
      // Uncomment the line below and ensure TLoaders is correctly imported
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Hide loader after fetching (whether successful or not)
      isLoading.value = false;
    }
  }
}
