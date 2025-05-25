import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Đảm bảo import này
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/device/device_utility.dart'; // Đảm bảo import này

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Bỏ const ở constructor vì các thuộc tính không phải lúc nào cũng là const
  const TAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false, // Nên để giá trị mặc định cho showBackArrow
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;
  final List<Widget>? actions; // Moved actions here for better readability


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md), // TSizes.md cần là const
      child: AppBar(
        automaticallyImplyLeading: false, // Bỏ const ở đây nếu có (không thấy trong code bạn)
        leading: showBackArrow
            ? IconButton(onPressed: () => Get.back(),icon: const Icon(Iconsax.arrow_left),)
            : (leadingIcon != null ? IconButton( onPressed: leadingOnPressed, icon: Icon(leadingIcon!),) : null),
        title: title, // title là Widget?, có thể là non-const
        actions: actions, // actions là List<Widget>?, có thể chứa non-const
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}