import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../features/personalization/controllers/my_orders_controller.dart';
import '../../../features/personalization/models/order_model.dart';
import '../../../features/personalization/screens/my_orders/widgets/AddressEditPopup.dart';
import '../../../utils/constants/color.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/t_rounded_image.dart';
import '../../styles/shadow.dart';
import '../texts/product_title_text.dart';

class TOrderCardHorizontal extends StatelessWidget {
  const TOrderCardHorizontal({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final DateFormat dateTimeFormatter = DateFormat('MMM dd, hh:mm a');

    // Xác định màu border dựa trên sự tồn tại của địa chỉ và số điện thoại
    final bool hasMissingDetails = (order.address == null || order.address!.isEmpty || order.phoneNumber == null || order.phoneNumber!.isEmpty);
    final Color borderColor = hasMissingDetails
        ? TColors.error // Màu đỏ nếu thiếu địa chỉ hoặc số điện thoại
        : (dark ? TColors.darkerGrey : TColors.white); // Màu mặc định

    // Lấy instance của OrderController
    final orderController = Get.find<OrderController>();

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          border: Border.all(color: borderColor),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        // Thay đổi cấu trúc chính: sử dụng Column để tạo 2 hàng
        child: Column(
          children: [
            /// Row 1: Ảnh và thông tin chung của đơn hàng
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center, // Đảm bảo căn chỉnh đầu các phần tử
              children: [
                /// -- Auction Product Thumbnail
                TRoundedContainer(
                  height: 120,
                  width: 120,
                  padding: const EdgeInsets.all(TSizes.sm),
                  backgroundColor: dark ? TColors.dark : TColors.light,
                  child: TRoundedImage(
                    imageUrl: order.auctionImage,
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwSections),

                /// -- Order Details (Thông tin chung)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ID Đơn hàng
                      Text(
                        'Order ID: #${order.id}',
                        style: Theme.of(context).textTheme.titleSmall!.apply(
                          color: TColors.primary,
                          fontWeightDelta: 2,
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),

                      // Tên sản phẩm đấu giá
                      TProductTitleText(
                        title: order.auctionName,
                        smallSize: true,
                        maxLines: 2,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),

                      // Số tiền
                      Text(
                        'Amount: \$${order.amount}',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(fontWeightDelta: 2),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),

                      // Trạng thái
                      TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: _getStatusColor(order.status, dark),
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          order.status.capitalizeFirst!,
                          style: Theme.of(context).textTheme.labelSmall!.apply(color: TColors.white),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),

                      // Thời gian tạo đơn hàng
                      Text(
                        'Order Date: ${dateTimeFormatter.format(order.createdAt.toLocal())}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),

                      // Thời gian thanh toán (nếu có)
                      if (order.paidAt != null) ...[
                        const SizedBox(height: TSizes.spaceBtwItems / 4),
                        Text(
                          'Paid Date: ${dateTimeFormatter.format(order.paidAt!.toLocal())}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            /// Dòng phân cách giữa 2 phần
            const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa 2 Row
            const Divider(), // Đường kẻ phân cách
            const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách sau đường kẻ

            /// Row 2: Delivery Information
            Align( // Đảm bảo toàn bộ phần Delivery Info được căn trái
              alignment: Alignment.centerLeft,
              child: Column( // Sử dụng Column bên trong Align để giữ các Text trên các dòng riêng
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề nhỏ cho phần thông tin giao hàng
                  Text(
                    'Delivery Info:',
                    style: Theme.of(context).textTheme.labelMedium!.apply(fontWeightDelta: 1),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 4),

                  // Số điện thoại (có thể click để sửa)
                  InkWell(
                    onTap: () {
                      if (hasMissingDetails) {
                        _showEditDetailsPopup(context, order, orderController);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 4),
                      child: Text(
                        (order.phoneNumber != null && order.phoneNumber!.isNotEmpty)
                            ? 'Phone: ${order.phoneNumber}'
                            : 'Phone: N/A (Tap to Add)',
                        style: Theme.of(context).textTheme.labelSmall!.apply(
                          color: (order.phoneNumber == null || order.phoneNumber!.isEmpty) ? TColors.error : null,
                          decoration: (order.phoneNumber == null || order.phoneNumber!.isEmpty) ? TextDecoration.underline : null,
                        ),
                      ),
                    ),
                  ),

                  // Địa chỉ (có thể click để sửa)
                  InkWell(
                    onTap: () {
                      if (hasMissingDetails) {
                        _showEditDetailsPopup(context, order, orderController);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 4),
                      child: Text(
                        (order.address != null && order.address!.isNotEmpty)
                            ? 'Address: ${order.address}'
                            : 'Address: N/A (Tap to Add)',
                        style: Theme.of(context).textTheme.labelSmall!.apply(
                          color: (order.address == null || order.address!.isEmpty) ? TColors.error : null,
                          decoration: (order.address == null || order.address!.isEmpty) ? TextDecoration.underline : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to determine status color
  Color _getStatusColor(String status, bool isDarkMode) {
    switch (status.toLowerCase()) {
      case 'pending':
        return isDarkMode ? TColors.warning.withOpacity(0.8) : TColors.warning;
      case 'completed':
      case 'paid':
        return isDarkMode ? TColors.success.withOpacity(0.8) : TColors.success;
      case 'cancelled':
        return isDarkMode ? TColors.error.withOpacity(0.8) : TColors.error;
      case 'shipped':
        return isDarkMode ? TColors.info.withOpacity(0.8) : TColors.info;
      default:
        return isDarkMode ? TColors.grey.withOpacity(0.8) : TColors.grey;
    }
  }

  // Hàm hiển thị popup chỉnh sửa chi tiết
  void _showEditDetailsPopup(BuildContext context, OrderModel order, OrderController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddressEditPopup(
          initialAddress: order.address,
          initialPhoneNumber: order.phoneNumber,
          onSave: (newAddress, newPhoneNumber) {
            controller.updateOrderDetails(order.id, newAddress, newPhoneNumber);
          },
        );
      },
    );
  }
}