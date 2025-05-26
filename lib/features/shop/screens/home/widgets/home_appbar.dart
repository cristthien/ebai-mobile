import 'package:flutter/material.dart';

import '../../../../../common/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../data/local_storage/local_storage.dart';
import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  // Hàm này sẽ đọc username từ local storage
  Future<String?> _loadUserName() async { // Thay đổi kiểu trả về thành String?
    final localStorage = TLocalStorage();
    final userName = localStorage.readData<String>('username');
    return userName; // Trả về null nếu không tìm thấy
  }

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)),
          // Sử dụng FutureBuilder để hiển thị username
          FutureBuilder<String?>( // Thay đổi kiểu FutureBuilder thành String?
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

              // Trạng thái: Dữ liệu đã tải xong
              // userName sẽ là null nếu không tìm thấy 'username'
              final userName = snapshot.data;

              return Text(
                userName ?? TTexts.homeAppbarSubTitle, // Hiển thị username hoặc 'Guest User'
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
              );
            },
          ),
        ],
      ),
      actions: [
        // Sử dụng FutureBuilder một lần nữa để kiểm tra sự tồn tại của username
        FutureBuilder<String?>(
          future: _loadUserName(), // Gọi lại hàm đọc username
          builder: (context, snapshot) {
            // Hiển thị CartIcon chỉ khi username tồn tại và không có lỗi
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
              return TCartCounterIcon(onPressed: () {}, iconColor: TColors.white);
            }
            // Nếu không có username hoặc đang tải, không hiển thị gì cả
            return const SizedBox.shrink(); // Widget rỗng
          },
        ),
      ],
    );
  }
}