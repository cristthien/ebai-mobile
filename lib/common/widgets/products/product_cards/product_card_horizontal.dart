import 'package:ebai/common/widgets/texts/product_price_text.dart';
import 'package:ebai/common/widgets/texts/product_title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../features/personalization/models/short_product_management_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/color.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../custom_shapes/containers/rounded_container.dart';
import '../../../images/t_rounded_image.dart';
import '../../../styles/shadow.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, required this.product});
  final ShortProductManagementModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final DateFormat formatter = DateFormat('MMM dd, yyyy HH:mm');
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(slug: product.slug)),
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm), // Padding tổng thể của thẻ
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow], // Hoặc một style shadow khác cho horizontal
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Thumbnail
            TRoundedContainer(
              height: 120, // Chiều cao cố định cho ảnh thumbnail trong thẻ ngang
              width: 120, // Chiều rộng cố định cho ảnh thumbnail
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: TRoundedImage(imageUrl: product.image, applyImageRadius: true, isNetworkImage: true)
            ),
            const SizedBox(width: TSizes.spaceBtwSections), // Khoảng cách giữa ảnh và chi tiết
            /// -- Details (Tên, Brand, Giá, Add to Cart)
            Expanded( // Expanded để phần chi tiết chiếm hết không gian còn lại
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: product.name, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Flexible(child: TProductPriceText(price: product.highestBid)),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    'Start: ${formatter.format(product.startDate)}',
                    style: Theme.of(context).textTheme.labelSmall, // Có thể dùng labelSmall hoặc bodySmall
                  ),
                  Text(
                    'End: ${formatter.format(product.endDate)}',
                    style: Theme.of(context).textTheme.labelSmall,
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