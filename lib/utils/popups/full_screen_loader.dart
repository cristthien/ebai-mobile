import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/loaders/animation_loader.dart';
import '../constants/color.dart';
import '../helpers/helper_functions.dart';

/// Helper functions for showing loading dialog
class TFullScreenLoader {
  /// Open a loading dialog with a given text and animation
  /// Parameters:
  ///   - text: The text to be shown below the animation.
  ///   - animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope( // Use PopScope instead of WillPopScope
        canPop: false, // Disable popping with the back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250), // Adjust the spacing as needed
              TAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}