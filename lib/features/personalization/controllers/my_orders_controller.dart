import 'package:get/get.dart';
// Import your OrderModel
import '../../../data/services/order_service.dart'; // Đảm bảo import đúng service
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/order_model.dart'; // Đảm bảo import đúng model

/// A controller class for managing order-related logic and state.
class OrderController extends GetxController {
  /// Singleton instance of OrderController.
  static OrderController get instance => Get.find();

  /// Observable boolean to indicate if orders are currently loading.
  final isLoading = false.obs;

  /// Observable list of fetched orders.
  RxList<OrderModel> userOrders = <OrderModel>[].obs; // Đổi từ userInvoices thành userOrders

  /// Instance of the OrderService to make API calls.
  final orderService = TOrderService(); // Đổi từ invoiceService thành orderService

  /// Called when the controller is initialized.
  /// Fetches user orders upon initialization.
  @override
  void onInit() {
    fetchUserOrders(); // Đổi từ fetchUserInvoices thành fetchUserOrders
    super.onInit();
  }

  /// Fetches orders for the current user from the service.
  /// Shows a loader while fetching and handles errors.
  void fetchUserOrders() async { // Đổi từ fetchUserInvoices thành fetchUserOrders
    try {
      // Show loader while loading orders
      isLoading.value = true;

      // Fetch Orders
      final orders = await orderService.getOrdersList(); // Gọi getOrdersList từ orderService
      print("Fetched Orders: $orders"); // For debugging
      // Assign fetched orders to the observable list
      userOrders.assignAll(orders); // Gán vào userOrders
    } catch (e) {
      // Catch error and display a snackbar message
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Hide loader after fetching (whether successful or not)
      isLoading.value = false;
    }
  }
  void updateOrderDetails(int orderId, String newAddress, String newPhoneNumber) async {
    try {
      // 1. Hiển thị loader toàn màn hình

      TFullScreenLoader.openLoadingDialog(
          'Updating order details...', TImages.docerAnimation); // Đảm bảo bạn có TImages.docerAnimation
      final orderIndex = userOrders.indexWhere((order) => order.id == orderId);
      if (orderIndex != -1) {
        final currentOrder = userOrders[orderIndex];
        final String invoiceId = currentOrder.id.toString();
        await orderService.updateInvoiceDetails(
          invoiceId: invoiceId,
          address: newAddress,
          phoneNumber: newPhoneNumber,
        );
        final updatedOrder = OrderModel(
          id: currentOrder.id,
          userID: currentOrder.userID,
          amount: currentOrder.amount,
          status: currentOrder.status,
          createdAt: currentOrder.createdAt,
          paidAt: currentOrder.paidAt,
          paymentMethod: currentOrder.paymentMethod,
          address: newAddress, // <--- Cập nhật địa chỉ mới
          phoneNumber: newPhoneNumber, // <--- Cập nhật số điện thoại mới
          auctionId: currentOrder.auctionId,
          auctionName: currentOrder.auctionName,
          auctionSlug: currentOrder.auctionSlug,
          auctionImage: currentOrder.auctionImage,
        );

        userOrders[orderIndex] = updatedOrder;
        userOrders.refresh(); // Bắt buộc refresh để Obx nhận ra thay đổi trên phần tử

        TLoaders.successSnackBar(title: 'Success!', message: 'Order details updated successfully.');

      } else {
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Order not found locally.');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Failed to update order details: $e');
    } finally {
      // 5. Đóng loader
      TFullScreenLoader.stopLoading();
    }
  }
}