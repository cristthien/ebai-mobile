import 'package:ebai/utils/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
              children: [
                /// Logo, Title & Sub-Title
                TLoginHeader(dark: dark),
                TLoginForm(dark: dark)]),
        ),
      ),
    );
  }
}


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
                SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, child: const Text(TTexts.createAccount))),
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

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:TSizes.spaceBtwItems), // Default padding, you can adjust this
          child: Image(
            height: 80,
            image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
          ),
        ),
        Text(TTexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
        Text(TTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}