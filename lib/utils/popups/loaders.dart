import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/color.dart';
import '../helpers/helper_functions.dart'; // Đảm bảo bạn đã thêm package iconsax vào pubspec.yaml; // Thay thế bằng đường dẫn thực tế đến file TColors của bạn

class TLoaders {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: THelperFunctions.isDarkMode(Get.context!) ? TColors.darkerGrey.withOpacity(0.9) : TColors.grey.withOpacity(0.9),
          ), // BoxDecoration
          child: Center(child: Text(message, style: Theme.of(Get.context!).textTheme.labelLarge)),
        ), // Container
      ), // SnackBar
    );
  }
  // Phương thức hiển thị snackbar thành công
  static successSnackBar({required String title, String message = '', int duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText:  TColors.white,
      backgroundColor: TColors.primary, // Đảm bảo TColors.primary được định nghĩa
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: TColors.white),
    );
  }

  // Phương thức hiển thị snackbar cảnh báo
  static warningSnackBar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }
  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }

}