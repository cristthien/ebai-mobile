import 'package:ebai/navigation_menu.dart';
import 'package:ebai/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/login/login_controller.dart';
import '../../signup/signup.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = THelperFunctions.isDarkMode(context);
    return Column(children: [
      Form(
        key:controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections), // Default padding, you can adjust this
          child: Column(
              children: [
                /// Email
                TextFormField(
                  controller: controller.email,
                  validator: (value) => TValidator.validateEmail(value),
                  expands: false,
                  decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax
                      .direct)),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Password
                Obx(()=> TextFormField(
                  controller: controller.password,
                  validator: (value) => TValidator.validatePassword(value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: TTexts.password,
                    suffixIcon: IconButton(
                        icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value ),
                  ),
                ),),
                const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                /// Remember Me & Forget Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Remember Me
                    Row(
                      children: [
                       Obx(()=> Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                        const Text(TTexts.rememberMe),
                      ],
                    ),

                    /// Forget Password
                    TextButton(onPressed: () => Get.to(() => const NavigationMenu()), child: const Text(TTexts.forgotPassword ) ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                /// Sign In Button
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed:() => controller.login(), child: const Text(TTexts.signIn))),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Create Account Button
                SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () =>  Get.to(() => const SignupScreen()), child: const Text(TTexts.createAccount))),
                const SizedBox(height: TSizes.spaceBtwSections),

              ]
          ),
        ),
      )
      ,Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(color: dark? TColors.darkerGrey: TColors.grey, thickness: 0.5, indent: 60, endIndent: 5)
        ],),
    ],
    );
  }
}

