import 'package:ebai/common/widgets/icons/t_circular_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/appbar/appbar.dart';
import '../../../../../common/images/t_rounded_image.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        padding: const EdgeInsets.only(top: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
        child: Column(
        children: [Stack(
          children: [
            /// Main Large Image
            const SizedBox(
              height: 350,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius ) ,
                child: Center(child: Image(image: AssetImage(TImages.productImage1))),
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
          itemCount: 6,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
          itemBuilder: (_, index) => TRoundedImage(
            width: 80,
            backgroundColor: dark ? TColors.dark : TColors.white,
            border: Border.all(color: TColors.primary),
            padding: const EdgeInsets.all(TSizes.sm),
            imageUrl: TImages.productImage1,
          ), // TRoundedImage
        ), // ListView.separated
      )), ],), // Stack
      ), // Container
    );
  }
}