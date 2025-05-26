import 'package:flutter/material.dart';

import '../../../../../common/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../data/local_storage/local_storage.dart';
import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/text_strings.dart';// <--- Import TLocalStorage

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  // Hàm này sẽ đọc username từ local storage
  Future<String> _loadUserName() async {
    final localStorage = TLocalStorage();
    // Lấy 'user_name' từ TLocalStorage, mặc định là 'Guest User' nếu không tìm thấy
    final userName = localStorage.readData<String>('username') ?? TTexts.homeAppbarSubTitle;
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)),
          // Sử dụng FutureBuilder để hiển thị username
          FutureBuilder<String>(
            future: _loadUserName(), // Gọi hàm đọc username
            builder: (context, snapshot) {
              // Trạng thái: Đang tải dữ liệu
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Loading Name...', // Hiển thị trạng thái tải
                  style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
                );
              }

              // Trạng thái: Có lỗi xảy ra khi tải dữ liệu
              if (snapshot.hasError) {
                print('Error loading username: ${snapshot.error}'); // In lỗi ra console để debug
                return Text(
                  'Error User', // Hiển thị lỗi
                  style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
                );
              }

              // Trạng thái: Dữ liệu đã tải xong và không có lỗi
              final userName = snapshot.data ?? TTexts.homeAppbarSubTitle; // Lấy username hoặc giá trị mặc định

              return Text(
                userName, // <--- Áp dụng username từ TLocalStorage
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
              );
            },
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(onPressed: () {}, iconColor: TColors.white),
      ],
    );
  }
}