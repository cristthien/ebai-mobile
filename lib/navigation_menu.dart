import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart'; // Đảm bảo import Iconsax

import '../../features/authentication/screens/login/login.dart'; // Import LoginScreen
import '../../features/personalization/screens/settings/settings.dart'; // Import SettingsScreen
import '../../features/shop/screens/home/home.dart'; // Import HomeScreen
import '../../data/local_storage/local_storage.dart'; // Đảm bảo đường dẫn đúng đến TLocalStorage của bạn

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    // final darkMode = THelperFunctions.isDarkMode(context); // Nếu bạn có THelperFunctions

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.handleNavigation(index),
          // backgroundColor: darkMode ? TColors.black : Colors.white, // Sử dụng màu nền động nếu có
          backgroundColor: Colors.white, // Ví dụ màu tĩnh nếu không có darkMode
          indicatorColor: const Color.fromARGB(25, 0, 0, 0), // Màu chỉ báo tĩnh
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ), // NavigationBar
      ), // Obx
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    ); // Scaffold
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;


  final List<Widget> screens = [
    const HomeScreen(),
    Container(color: Colors.purple), // Placeholder for StoreScreen
    Container(color: Colors.orange), // Placeholder for FavouritesScreen
    const SettingsScreen(), // Giữ nguyên SettingsScreen ở đây
  ];

  // Hàm xử lý khi một destination được chọn
  void handleNavigation(int index) async {
    if (index == 3) {
      final accessToken = await TLocalStorage().readData<String>(
          'access_token');
      print(
          'Profile tab selected. Checking access_token: $accessToken'); // Để debug

      if (accessToken != null && accessToken.isNotEmpty) {
        // Nếu có access_token, hiển thị SettingsScreen
        selectedIndex.value = index;
      } else {
        // Nếu không có access_token, điều hướng về LoginScreen
        // Và không thay đổi selectedIndex để người dùng không thấy tab 'Profile' sáng lên
        Get.offAll(() => const LoginScreen());
        // Tùy chọn: bạn có thể reset selectedIndex về 0 (Home) nếu muốn.
        // selectedIndex.value = 0;
      }
    } else {
      // Đối với các tab khác, chỉ cần cập nhật selectedIndex bình thường
      selectedIndex.value = index;
    }
  }
}