
import 'package:ebai/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../data/services/authentication_services.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final authenticationServices= AuthenticationServices();

  Future<void > login() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Loging you in .......', TImages.docerAnimation);
      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      //if (!isConnected) return;
      //Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Privacy Policy Check


      /// Signup
      final userRespone = await authenticationServices.login(
        email: email.text.trim(),
        password: password.text.trim(),);
      final userData = userRespone['data'];


      if (rememberMe.value) {
        localStorage.write('access_token', userData['access_token']);
        localStorage.write('username',userData['user']['username'] );
        localStorage.write('role', userData['user']['role']);
      }

      TFullScreenLoader.stopLoading();
      // // Show Success Message
      Get.to(() => NavigationMenu());
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}