import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../signup/signup.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
    required this.dark,
  });
  final bool dark;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections), // Default padding, you can adjust this
          child: Column(
              children: [
                /// Email
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Password
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: TTexts.password,
                    suffixIcon: IconButton(icon: const Icon(Iconsax.eye_slash), onPressed: () {}),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                /// Remember Me & Forget Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Remember Me
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        const Text(TTexts.rememberMe),
                      ],
                    ),

                    /// Forget Password
                    TextButton(onPressed: () {}, child: const Text(TTexts.forgotPassword  ) ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                /// Sign In Button
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text(TTexts.signIn))),
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

