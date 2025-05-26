import 'package:ebai/common/texts/section_heading.dart';
import 'package:ebai/common/widgets/layouts/grid_layout.dart';
import 'package:ebai/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ebai/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ebai/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ebai/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/custom_shapes/containers/circular_container_widget.dart';
import '../../../../common/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../controllers/product_controller.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
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
                        /// Heading
                        TSectionHeading(title: 'Popular Categories', showActionButton: false, textColor: Colors.white),
                        SizedBox(height: TSizes.spaceBtwItems),
                        /// Categories
                        THomeCategories(), // SizedBox

                      ],
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            ///Body
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                  children: [
                    // -- Promo slider
                    const TPromoSlider(banners: [TImages.promoBanner1, TImages.promoBanner2, TImages.promoBanner3]),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Obx((){
                      if (controller.isLoading.value) return const TVerticalProductShimmer();
                      if (controller.featuredProducts.isEmpty) {
                        return Center(child: Text('No Products Found', style: Theme.of(context).textTheme.bodyMedium));
                      } ;

                      return TGridLayout(itemCount: controller.featuredProducts.length, itemBuilder: (_, i) => TProductCardVertical(product: controller.featuredProducts[i]));

                    } )
                    // -- Popular product

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
