import 'package:ebai/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/appbar/appbar.dart';
import '../../../../common/custom_shapes/containers/rounded_container.dart';
import '../../../../common/custom_shapes/containers/search_container.dart';
import '../../../../common/texts/section_heading.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/color.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        /// -- Appbar -- Tutorial [Section # 3, Video # 7]
        appBar: TAppBar(), /// TAppBar
        body: NestedScrollView( // Đây là body chính của Scaffold
          /// -- Header -- Tutorial [Section # 3, Video # 7]
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 440, /// Space between Appbar and TabBar
              automaticallyImplyLeading: false,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
              flexibleSpace: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    /// -- Search bar
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSearchContainer(text: 'Search in Store', showBorder: true, showBackground: false),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// -- Featured Brands
                    TSectionHeading(title: 'Featured Brands', onPressed: () {}),
                    const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                    /// -- Brands GRID
                    TGridLayout(
                      itemCount: 4,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        /// In the Backend Tutorial we will pass the Each Brand & OnPress Event also.
                        return const TBrandCard(showBorder: false);
                      },
                    ),
                  ],
                ),
              ),

              /// Tab -- Tutorial
              bottom: const TTabBar(
                tabs: [
                  Tab(child: Text('Sports')),
                  Tab(child: Text('Furniture')),
                  Tab(child: Text('Electronics')),
                  Tab(child: Text('Clothes')),
                  Tab(child: Text('Cosmetics')),
                ],
              ), // TabBar
            ), // SliverAppBar
          ], // Kết thúc list của headerSliverBuilder

          /// --- Body -- Tutorial [Section # 3, Video # 8]

          body: const TabBarView(
            children: [TCategoryTab(), TCategoryTab(), TCategoryTab(), TCategoryTab(), TCategoryTab()], // Kết thúc children của TabBarView
          ), // Kết thúc TabBarView
        ), // Kết thúc body của NestedScrollView
      ), // Kết thúc Scaffold
    ); // Kết thúc DefaultTabController
  }
}

