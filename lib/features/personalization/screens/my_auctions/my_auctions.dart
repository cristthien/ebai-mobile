import 'package:flutter/material.dart'; // Sử dụng Material design
import 'package:get/get.dart';

import '../../../../common/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
// import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart'; // Không cần nếu dùng Vertical
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart'; // Sử dụng ProductCardVertical
// import '../../../../common/widgets/shimmers/horizontal_product_shimmer.dart'; // Không cần nếu dùng Vertical
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart'; // Sử dụng VerticalProductShimmer
import '../../../../utils/constants/sizes.dart';
import '../../controllers/my_auctions_controller.dart'; // Đảm bảo tên controller là MyAuctionsController

class MyAuctions extends StatelessWidget {
  const MyAuctions({super.key});

  @override
  Widget build(BuildContext context) {
    // Đảm bảo tên controller khớp với import MyAuctionsController
    final controller = Get.put(ProductManagementController());

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('My Auctions')),
      body: SingleChildScrollView(
        child: Padding( // Thêm Padding để nội dung không bị dính vào cạnh
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Giả sử bạn có TSizes.defaultSpace
          child: Obx(() {
            // Hiển thị Shimmer khi đang tải
            if (controller.isLoading.value) {
              return const TVerticalProductShimmer(); // Sử dụng shimmer dọc
            }

            // Hiển thị thông báo nếu không có sản phẩm
            if (controller.featuredProducts.isEmpty) {
              return Center(
                child: Text(
                  'No Auctions Found!', // Thông báo rõ ràng hơn
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            return TGridLayout(
              itemCount: controller.featuredProducts.length,
              crossAxisCount:1,
              mainAxisExtent:140,
              itemBuilder: (_, index) => TProductCardHorizontal(
                product: controller.featuredProducts[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}