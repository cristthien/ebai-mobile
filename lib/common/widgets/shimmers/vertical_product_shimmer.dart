import 'package:ebai/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';

class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  /// The number of shimmer items to display.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    // Return a grid layout with shimmer effects for each item.
    return TGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image Shimmer
            TShimmerEffect(width: 180, height: 180),
            SizedBox(height: TSizes.spaceBtwItems),

            /// Text Shimmer
            TShimmerEffect(width: 160, height: 15),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            TShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}