import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/authentication/screens/login/login.dart';
import '../../features/authentication/screens/onboarding/onboarding.dart';
import '../../navigation_menu.dart';
import '../../utils/local_storage/storage_utility.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  screenRedirect() async {
    // Local Storage
    deviceStorage.writeIfNull('isFirstTime', true);
    final accessToken = await TLocalStorage().readData('access_token');
    if (accessToken != null) {
      Get.offAll(NavigationMenu());
    }else if (deviceStorage.read('isFirstTime')!= true ){
      Get.offAll(() => const LoginScreen());
    }else {
      Get.offAll(const OnBoardingScreen());
    }
  }



}

