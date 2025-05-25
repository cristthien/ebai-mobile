import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Assuming you use the lottie package for animations

import 'package:ebai/utils/constants/sizes.dart';

import '../../utils/constants/color.dart'; // Adjust import path as needed

/// A widget for displaying an animated loading indicator with optional text and action button.
class TAnimationLoaderWidget extends StatelessWidget {
  /// Parameters:
  ///   - text: The text to be displayed below the animation.
  ///   - animation: The Lottie animation to be shown.
  ///   - showAction: Whether to show an action button below the text.
  ///   - actionText: The text to be displayed on the action button.
  ///   - onPressed: Callback function to be executed when the action button is pressed.
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display Lottie animation
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
          ),
          const SizedBox(height: TSizes.defaultSpace), // Space between animation and text

          // Text
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium, // Adjust style as needed
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.defaultSpace), // Space between text and button
          showAction? SizedBox(
            width:250,
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(backgroundColor: TColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.light),
              ), // Text
            )
          ): const SizedBox()
        ],
      ),
    );
  }
}