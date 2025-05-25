import 'package:ebai/common/appbar/appbar.dart';
import 'package:ebai/common/texts/section_heading.dart';
import 'package:ebai/common/widgets/layouts/grid_layout.dart';
import 'package:ebai/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ebai/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ebai/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ebai/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/custom_shapes/containers/circular_container_widget.dart';
import '../../../../common/custom_shapes/containers/search_container.dart';
import '../../../../common/image_text_widgets/vertical_image_text.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/image_strings.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            /// Tutorial [Section # 3, Video # 2]
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  THomeAppBar(), // TAppBar
                  SizedBox(height: TSizes.spaceBtwSections),
                  /// Search Bar
                  TSearchContainer(text: 'Search in Store'),
                  SizedBox(height: TSizes.spaceBtwSections),
                  /// Categories
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(title: 'Popular Categories', showActionButton: false, textColor: Colors.white),
                        SizedBox(height: TSizes.spaceBtwItems),
                        THomeCategories(), // SizedBox

                      ]
                    )
                  ),
                ],
              ), // Column, TPrimaryHeaderContainer
            ), // Column
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                  children: [
                    // -- Promo slider
                    const TPromoSlider(banners: [TImages.promoBanner1, TImages.promoBanner2, TImages.promoBanner3]),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // -- Popular product
                    TGridLayout(itemCount: 2, itemBuilder: (_, index) => const TProductCardVertical())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
