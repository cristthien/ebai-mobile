// Imports cần thiết (bạn cần thêm vào đầu file của TSearchContainer)
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';


class TSearchContainer extends StatelessWidget {
  // Bỏ const ở constructor vì các thuộc tính như 'text' không phải lúc nào cũng là const
  // và 'icon' có giá trị mặc định là Iconsax.search_normal (là const), nhưng constructor vẫn có thể nhận giá trị động.
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal, // Giá trị mặc định là const
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
          // color không thể là const vì phụ thuộc vào biến 'dark'
          color: showBackground ? (dark ? TColors.dark : TColors.light) : Colors.transparent,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          // border không thể là const vì phụ thuộc vào biến 'showBorder'
          border: showBorder ? Border.all(color: TColors.grey) : null,
        ), // BoxDecoration
        child: Row(
          children: [
            // Icon có thể là const nếu 'icon' là const IconData
            const Icon(Iconsax.search_normal, color: TColors.darkerGrey), // Từ ảnh chụp, Iconsax.search_normal được dùng trực tiếp
            const SizedBox(width: TSizes.spaceBtwItems),
            // Text không thể là const vì 'text' là biến động
            // Style không thể là const vì Theme.of(context) là động
            Text(text, style: Theme.of(context).textTheme.bodySmall),
          ],
        ), // Row
      ), // Container
    ); // Padding
  }
}