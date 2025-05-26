import 'package:ebai/common/widgets/texts/product_price_text.dart';
import 'package:ebai/common/widgets/texts/product_title_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/models/short_product_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/color.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../custom_shapes/containers/rounded_container.dart';
import '../../../images/t_rounded_image.dart';
import '../../../styles/shadow.dart';
import '../../icons/t_circular_icon.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});
  final ShortProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    /// Container with side paddings, color, edges, radius and shadow.
    return GestureDetector(
      onTap: () => Get.to(() =>  ProductDetailScreen(slug: product.slug)  ),
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  TRoundedImage(imageUrl: product.image, applyImageRadius: true,isNetworkImage: true),
      
                  /// -- Sale Tag
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black)),
                    ), // TRoundedContainer
                  ), // Positioned
      
                  /// -- Favourite Icon Button
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(icon: Iconsax.heart5, color: Colors.red),
                  ), // Container
      
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems/2),
            /// -- Detail
          Padding(
            padding: const EdgeInsets.only(left: TSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TProductTitleText(title: product.name, smallSize: true),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  children: [
                    Text('Nike', overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(width: TSizes.xs),
                    const Icon(Iconsax.verify5, color: TColors.primary, size: TSizes.iconXs),
                  ],
                ), // Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Price
                  TProductPriceText(price: product.highestBid),

                  /// Add to cart button
                  Container(
                    decoration: const BoxDecoration(
                      color: TColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusMd),
                        bottomRight: Radius.circular(TSizes.productImageRadius),
                      ), // BorderRadius.only
                    ), // BoxDecoration
                    child: const SizedBox(
                      width: TSizes.iconLg * 1.2,
                      height: TSizes.iconLg * 1.2,
                      child: Center(child: Icon(Iconsax.add, color: TColors.white)),
                    ), // SizedBox
                  ), // Container
                ],
              ),
              ],
      
      
              ),
            ),
          ],
        ),
      ),
    );
  }
}

