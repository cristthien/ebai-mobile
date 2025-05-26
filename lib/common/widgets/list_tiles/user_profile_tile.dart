import 'package:flutter/material.dart'; // Sử dụng Material.dart cho các widget UI
import 'package:iconsax/iconsax.dart';

import '../../../data/local_storage/local_storage.dart';
import '../../../utils/constants/color.dart';
import '../../../utils/constants/image_strings.dart'; // <--- Import TLocalStorage
import '../../../utils/constants/image_strings.dart'; // <--- Import TLocalStorage
import '../images/t_circular_images.dart'; // Đảm bảo đường dẫn đúng

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
  });

  // Hàm này sẽ đọc dữ liệu người dùng từ local storage
  Future<Map<String, String>> _loadUserData() async {
    final localStorage = TLocalStorage();
    // Lấy dữ liệu với các key bạn đã dùng để lưu
    final name = localStorage.readData<String>('username') ?? 'Guest User';
    final email = localStorage.readData<String>('email') ?? 'guest@example.com';
    final profilePicture = localStorage.readData<String>('user_profile_picture') ?? ''; // URL ảnh profile

    return {
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _loadUserData(), // Gọi hàm đọc dữ liệu
      builder: (context, snapshot) {
        // Trạng thái: Đang tải dữ liệu
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListTile(
            leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
            title: Text(
              'Loading Name...',
              style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
            ),
            subtitle: Text(
              'Loading Email...',
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
            ),
            trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit, color: TColors.white)),
          );
        }

        // Trạng thái: Có lỗi xảy ra khi tải dữ liệu
        if (snapshot.hasError) {
          print('Error loading user data: ${snapshot.error}'); // In lỗi ra console để debug
          return ListTile(
            leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
            title: Text(
              'Error Loading User',
              style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
            ),
            subtitle: Text(
              'Please try again.',
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
            ),
            trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit, color: TColors.white)),
          );
        }

        // Trạng thái: Dữ liệu đã tải xong và không có lỗi
        // snapshot.data chứa Map<String, String> từ _loadUserData()
        final userData = snapshot.data!;
        final userName = userData['name']!;
        final userEmail = userData['email']!;
        final userProfilePicture = userData['profilePicture']!;

        return ListTile(
          leading: TCircularImage(
            // Nếu có URL ảnh profile, dùng nó, ngược lại dùng ảnh mặc định
            image: userProfilePicture.isNotEmpty ? userProfilePicture : TImages.user,
            // Nếu có URL ảnh profile, đặt isNetworkImage là true
            isNetworkImage: userProfilePicture.isNotEmpty,
            width: 50,
            height: 50,
            padding: 0,
          ),
          title: Text(
            userName, // <--- Áp dụng tên người dùng từ TLocalStorage
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
            maxLines: 1, // Giới hạn 1 dòng
            overflow: TextOverflow.ellipsis, // Hiển thị "..." nếu text quá dài
          ),
          subtitle: Text(
            userEmail, // <--- Áp dụng email người dùng từ TLocalStorage
            style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
            maxLines: 1, // Giới hạn 1 dòng
            overflow: TextOverflow.ellipsis, // Hiển thị "..." nếu text quá dài
          ),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit, color: TColors.white)),
        );
      },
    );
  }
}