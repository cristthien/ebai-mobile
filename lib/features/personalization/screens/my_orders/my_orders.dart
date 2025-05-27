import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/appbar/appbar.dart';
import '../../../../common/widgets/invoices/invoices_card.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart'; // Giữ shimmer dọc hoặc tạo order shimmer nếu cần
import '../../../../utils/constants/sizes.dart';
import '../../controllers/my_orders_controller.dart';

class MyOrders extends StatelessWidget { // <-- Đổi tên class thành MyOrdersScreen
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    // <-- Khởi tạo hoặc tìm OrderController
    final controller = Get.put(OrderController());

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('My Orders')), // <-- Đổi tiêu đề
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() {
            // Hiển thị Shimmer khi đang tải
            if (controller.isLoading.value) {
              return const TVerticalProductShimmer(); // Sử dụng shimmer dọc chung
            }

            // Hiển thị thông báo nếu không có đơn hàng
            if (controller.userOrders.isEmpty) { // <-- Kiểm tra userOrders
              return Center(
                child: Text(
                  'No Orders Found!', // <-- Thông báo cho đơn hàng
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            return TGridLayout(
              itemCount: controller.userOrders.length, // <-- Sử dụng userOrders
              crossAxisCount: 1, // Để hiển thị dạng danh sách hàng ngang
              mainAxisExtent: 300, // <-- Điều chỉnh chiều cao cho phù hợp với TOrderCardHorizontal
              itemBuilder: (_, index) => TOrderCardHorizontal( // <-- Sử dụng TOrderCardHorizontal
                order: controller.userOrders[index], // <-- Truyền OrderModel vào
              ),
            );
          }),
        ),
      ),
    );
  }
}