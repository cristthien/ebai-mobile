

import 'package:ebai/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:flutter/material.dart';

import '../../../../../common/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key, required this.title, required this.slug, required this.condition
  });
  final String title,slug, condition;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        TProductTitleText(title: title),
            /// Title
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

    ],
    );
  }
}