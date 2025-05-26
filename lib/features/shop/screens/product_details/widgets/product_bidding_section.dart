// --- file: lib/app/modules/bidding/views/product_bidding_section.dart ---
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/bidding_controller.dart'; // Để định dạng số tiền
class ProductBiddingSection extends StatefulWidget {
  const ProductBiddingSection({
    super.key,
    required this.slug,
    required this.endDate,
  });

  final String slug;
  final DateTime endDate;

  @override
  State<ProductBiddingSection> createState() => _ProductBiddingSectionState();
}

class _ProductBiddingSectionState extends State<ProductBiddingSection> {
  late BiddingController _biddingController;

  @override
  void initState() {
    super.initState();
    _biddingController = Get.put(BiddingController(
      productSlug: widget.slug,
      endDate: widget.endDate,
    ));
    print('ProductBiddingSection: BiddingController initialized for slug: ${widget.slug}');
  }

  @override
  void dispose() {
    // Khi widget bị dispose, chúng ta cũng loại bỏ controller khỏi GetX
    // Điều này đảm bảo tài nguyên được giải phóng đúng cách
    Get.delete<BiddingController>();
    print('ProductBiddingSection: BiddingController disposed for slug: ${widget.slug}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng GetBuilder để lắng nghe các thay đổi trong controller
    // hoặc Obx nếu bạn chỉ muốn lắng nghe các biến Rx cụ thể
    return GetBuilder<BiddingController>(
      init: _biddingController, // Truyền controller đã khởi tạo
      builder: (controller) {
        // Biến 'controller' ở đây chính là instance của BiddingController
        // mà chúng ta đã khởi tạo trong initState.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 2. Main auction information
            Obx(() {
              // final bidInfo = controller.bids.value;
              final highestBid = controller.highestBid.value;
              final numOfBid = controller.numOfBid.value;
              final highestBider = controller.highestBider.value;
              final formattedHighestBid = NumberFormat.currency(locale: 'en_US', symbol: '\$')
                  .format(highestBid ?? 0);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current highest bid:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    formattedHighestBid,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'HighestBid: $numOfBid',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  Text(
                    'Number of bids: $highestBider',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'Time remaining:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    controller.timeLeft.value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),

            // 3. Input field for bid amount
            Obx(() => TextField(
              controller: controller.bidAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your bid amount',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.attach_money),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.setBidAmount('');
                  },
                ),
              ),
              onChanged: (value) {
                controller.setBidAmount(value);
              },
              enabled: !controller.isDisabled.value,
            )),
            const SizedBox(height: 16),

            // 4. "Place Bid" button
            Obx(() {
              final isDisabled = controller.isDisabled.value;
              final bidAmount = controller.bidAmount.value;

              // Nút vẫn được nhấn nếu bidAmount rỗng, miễn là không bị isDisabled
              final isButtonEnabled = !isDisabled;

              // Màu sắc của nút: màu xám nếu bidAmount rỗng HOẶC isDisabled
              final buttonColor = (bidAmount.isEmpty || isDisabled)
                  ? Colors.grey
                  : TColors.primary;

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // onPressed chỉ bị null khi isDisabled là true (nhưng vẫn cho phép nhấn khi bidAmount rỗng)
                  onPressed: isButtonEnabled ? controller.placeBid : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: buttonColor, // Sử dụng màu sắc đã tính toán
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                      side: BorderSide.none,
                    ),
                  ),
                  child: const Text(
                    'Place Bid',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            })

          ],
        );

      },
    );
  }
}
