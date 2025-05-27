import 'package:ebai/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:ebai/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ebai/features/shop/screens/product_details/widgets/product_specification.dart';
import 'package:ebai/features/shop/screens/product_details/widgets/product_bidding_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../../../common/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product_detail_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.slug });
  final String slug;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController(productSlug: slug));
    return Scaffold(
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.productDetails.value == null) {
            return const Center(child: Text('Failed to load product details.'));
          } else {
            final product = controller.productDetails.value!;
            print(product.images);
            return SingleChildScrollView(
              child: Column(
                children: [
                  /// 1 - Product Image Slider
                  TProductImageSlider(images:product.images), // TCurvedEdgesWidget
                  /// 2 - Product Details
                  Padding (
                    padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// - Price, Title, Stock, & Brand
                        TProductMetaData(title: product.name, slug: product.slug, condition: product.condition),
                        ProductBiddingSection(
                          slug: product.slug,
                          endDate: product.endDate, // Truyền endDate từ ProductModel
                        ),
                        // BiddingComponent(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// -- Description
                        const TSectionHeading(title: 'Description', showActionButton: false),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        ReadMoreText(
                          product.description,
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' Show more',
                          trimExpandedText: ' Less',
                          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                        ), // ReadMoreText

                        /// -- Reviews
                        const Divider(),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        /// Chỉnh phần này thành specification
                        SpecificationSection(data:product.specifications),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),

                  )
                ],
              ), // Column
            ); // SingleChildScrollView
            }
        },
      ),
    ); // Scaffold
  }
}



