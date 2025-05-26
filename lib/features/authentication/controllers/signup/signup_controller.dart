import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/services/authentication_services.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final authenticationServices = AuthenticationServices();

  // Variables
  final hidePassword = true.obs;
  final hidePasswordVerification = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController(); // Controller for email input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final rePassword = TextEditingController(); // Controller for phone number input

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for form validation
  Future<void > signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information.....', TImages.docerAnimation);
      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      //if (!isConnected) return;
      //Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return; // Dừng việc thực hiện tiếp theo nếu chính sách chưa được chấp nhận
      }
      if (password.value != rePassword.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Password not same',
          message: 'In order to create account, you must have to add same password and password confirmation ',
        );
        return; // Dừng việc thực hiện tiếp theo nếu chính sách chưa được chấp nhận
      }

      // Signup
      await authenticationServices.register(
        username: username.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),);
      // Remove Loader
      TFullScreenLoader.stopLoading();
      // // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');
      Get.to(() => const VerifyEmailScreen());
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}