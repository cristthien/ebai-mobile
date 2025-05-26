
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
    decoration: BoxDecoration(
    color: dark ? TColors.darkerGrey : TColors.light,
    borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(TSizes.cardRadiusLg),
    topRight: Radius.circular(TSizes.cardRadiusLg),
    ), // BorderRadius.only
    ), // BoxDecoration
    child: Row(
    children: [
    Row(
    children: [
    TCircularIcon(
    icon: Iconsax.minus,
    backgroundColor: TColors.darkGrey,
    width: 40,
    height: 40,
    color: TColors.white
    ), // TCircularIcon
    ],
    ), // Row
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: TColors.black,
          side: const BorderSide(color: TColors.black),
        ),
        child: const Text('Add to Cart'),
      ) // ElevatedButton
    ],
    ), // Row
    ); // Container
  }
}