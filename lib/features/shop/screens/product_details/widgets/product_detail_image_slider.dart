import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebai/common/widgets/icons/t_circular_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../../common/appbar/appbar.dart';
import '../../../../../common/images/t_rounded_image.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product_image_slide.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key, required this.images
  });

  final List<String> images;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductImageController());
    if (images.isEmpty) return const SizedBox.shrink();
    controller.assignThumbnail(images[0]);
    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.white : TColors.white,
        padding: const EdgeInsets.only(top: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
        child: Column(
        children: [Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 350,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius ) ,
                child: Center(
                  child: Obx(
                        () {
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary),
                        ), // CachedNetworkImage
                      ); // GestureDetector
                    },
                  ), // Obx
                ), // Center
              ), // Padding
            ), // SizedBox

            /// Appbar Icons
            Positioned( // <--- THÊM POSITIONED VÀO ĐÂY
              top: - TSizes.defaultSpace, // <--- Đặt top = 20
              left: 0, // Đảm bảo nó nằm sát mép trái
              right: 0, // Đảm bảo nó nằm sát mép phải
              child: const TAppBar(
                showBackArrow: true,
                // Bạn có thể thêm actions ở đây nếu muốn:
                actions: [TCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
              ),
            ),
          ],
        ),
      Padding(
          padding: const EdgeInsets.only(left: TSizes.defaultSpace),
          child: SizedBox(
        height: 80,
            child: ListView.separated(
              itemCount: images.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(), // Đảm bảo cuộn được ngay cả khi nội dung ít
              separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
              itemBuilder: (_, index) => Obx(
                    () {
                  // Kiểm tra xem ảnh hiện tại có phải là ảnh đang được chọn hay không
                  final imageSelected = controller.selectedProductImage.value == images[index];
                  return TRoundedImage(
                    width: 80,
                    isNetworkImage: true, // Giả định đây là ảnh mạng
                    imageUrl: images[index], // URL của ảnh từ danh sách
                    padding: const EdgeInsets.all(TSizes.sm), // Padding xung quanh ảnh
                    backgroundColor: dark ? TColors.dark : TColors.white, // Màu nền động dựa trên chế độ sáng/tối
                    onPressed: () => controller.selectedProductImage.value = images[index], // Khi nhấn, cập nhật ảnh được chọn
                    border: Border.all(color: imageSelected ? TColors.primary : Colors.transparent), // Border nếu ảnh được chọn
                  ); // TRoundedImage
                },
              ),
            ),
      )), ],),
      ),
    );
  }
}