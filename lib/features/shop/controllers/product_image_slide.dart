import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';

class ProductImageController extends GetxController {

  static ProductImageController get instance => Get.find();

  RxString selectedProductImage= ''.obs;

  void assignThumbnail(String image) {
    selectedProductImage.value = image;
  }
  // -- Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Có thể lỗi nếu dùng với Dialog.fullscreen, thường thì sẽ không có tác dụng
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace),
              child:  CachedNetworkImage(imageUrl: image),
            ), // Padding
            const SizedBox(height: TSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
              ), // SizedBox
            ), // Align
          ],
        ), // Column
      ), // Dialog.fullscreen
    ); // Get.to
  }
}
