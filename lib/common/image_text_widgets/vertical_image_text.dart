// Imports cần thiết (bạn cần thêm vào đầu file của TVerticalImageText)
import 'package:flutter/material.dart';

import '../../utils/constants/color.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';


class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    this.image,
    this.icon,
    required this.title,
    this.textColor = TColors.white, // Mặc định là trắng
    this.backgroundColor,
    this.onTap,
  }): assert(image != null || icon != null, 'Either image or icon must be provided');

  final String? image;
  final String title;
  final IconData? icon;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap; // Changed from Function()? to VoidCallback? for clarity

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular Icon
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor ?? (dark ? TColors.black : TColors.white),
                borderRadius: BorderRadius.circular(100),
              ), // BoxDecoration
              child: Center(
                child: Center(
                  // Conditionally render Image or Icon
                  child: icon != null
                      ? Icon(
                    icon,
                    color: dark ? TColors.light : TColors.dark,
                    size: 30, // Adjust icon size as needed
                  )
                      : (image != null
                      ? Image(
                    image: AssetImage(image!), // Use image! as it's asserted to be not null if icon is null
                    fit: BoxFit.cover,
                    color: dark ? TColors.light : TColors.dark,
                  )
                      : const SizedBox.shrink() // Fallback if neither image nor icon is provided (shouldn't happen with assertion)
                  ),
                ),
              ), // Center
            ), // Container

            /// Text
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            SizedBox(
              width: 55, // Fixed width for the text to prevent overflow issues
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ), // Text
            ), // SizedBox
          ],
        ), // Column
      ), // Padding
    ); // GestureDetector
  }
}