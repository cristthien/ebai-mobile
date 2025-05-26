import 'package:get/get.dart'; // Đảm bảo đã import Getx
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../data/services/product_services.dart';
import '../../../utils/popups/loaders.dart';
import '../models/product_model.dart'; // Nếu bạn dùng dotenv trong controller

class ProductDetailController extends GetxController {
  /// Observable boolean to indicate if product details are currently loading.
  final isLoading = false.obs;

  /// Observable for the specific product's details.
  // Sử dụng Rx<ProductModel?> để giữ chi tiết của một sản phẩm, ban đầu là null
  Rx<ProductModel?> productDetails = Rx<ProductModel?>(null); // Khởi tạo với null

  // Bien slug de nhan tu man hinh truoc
  final String productSlug; // <--- THÊM BIẾN SLUG VÀO ĐÂY

  // Khởi tạo ProductService
  final TProductService _productService = TProductService(); // Đổi tên biến để tránh nhầm lẫn

  // Constructor để nhận slug
  ProductDetailController({required this.productSlug}); // <--- THÊM CONSTRUCTOR

  /// Called when the controller is initialized.
  @override
  void onInit() {
    fetchProductDetails(productSlug); // Gọi hàm mới để lấy chi tiết sản phẩm
    super.onInit();
  }

  /// Fetches specific product details by slug.
  /// Shows a loader while fetching and handles errors.
  void fetchProductDetails(String slug) async {
    try {
      // Show loader while loading
      isLoading.value = true;

      // Fetch specific product details using the service
      final product = await _productService.getAuctionBySlug(slug); // <--- SỬ DỤNG HÀM MỚI TỪ SERVICE

      // Assign Product Details
      productDetails.value = product; // Gán sản phẩm vào biến observable

    } catch (e) {
      // Catch error and display a snackbar message
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Hide loader after fetching
      isLoading.value = false;
    }
  }

// Bạn có thể bỏ hàm fetchNewListingProducts nếu controller này chỉ để xử lý chi tiết sản phẩm
// Nếu vẫn cần, hãy giữ nó và đảm bảo nó không gây nhầm lẫn về mục đích của controller
// void fetchNewListingProducts() async { ... }
}