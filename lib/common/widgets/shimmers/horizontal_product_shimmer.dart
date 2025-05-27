import 'package:ebai/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart'; // Đổi từ cupertino.dart sang material.dart
import '../../../utils/constants/sizes.dart';

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({
    super.key,
    this.itemCount = 4, // Số lượng shimmer items mặc định
  });

  /// The number of shimmer items to display.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox( // Bọc trong SizedBox để giới hạn chiều cao cho ListView ngang
      height: 120, // Chiều cao tương ứng với TProductCardHorizontal
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal, // Hướng cuộn ngang
        physics: const AlwaysScrollableScrollPhysics(), // Đảm bảo luôn cuộn được
        separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems), // Khoảng cách giữa các item
        itemBuilder: (_, __) => const SizedBox(
          width: 310, // Chiều rộng tương ứng với TProductCardHorizontal
          child: Row( // <-- Thay đổi chính: Sử dụng Row để bố cục ngang
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image Shimmer
              TShimmerEffect(width: 120, height: 120), // Kích thước ảnh ngang

              SizedBox(width: TSizes.spaceBtwItems), // Khoảng cách giữa ảnh và chi tiết

              /// Text Shimmer for details
              Expanded( // Expanded để phần text chiếm hết không gian còn lại
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Phân bố đều các dòng text
                  children: [
                    TShimmerEffect(width: 160, height: 15), // Dòng tiêu đề
                    TShimmerEffect(width: 80, height: 10), // Dòng phụ (brand)
                    TShimmerEffect(width: 120, height: 15), // Dòng giá
                    // Thêm một shimmner nhỏ cho nút nếu muốn
                    // TShimmerEffect(width: 50, height: 50), // Ví dụ cho nút
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}