import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../verify_email.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Column(
            children: [
              TextFormField(
                expands: false,
                decoration: const InputDecoration(labelText: TTexts.userName, prefixIcon: Icon(Iconsax
                    .user)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                expands: false,
                decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax
                    .direct)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(icon: const Icon(Iconsax.eye_slash), onPressed: () {}),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(icon: const Icon(Iconsax.eye_slash), onPressed: () {}),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              // ... more form fields will likely follow here
            ],
          ),
        ),
        /// Terms&Condition Checkbox
        Row(
          children: [
            SizedBox(width: 24, height: 24, child: Checkbox(value: true, onChanged: (value){},)),

            const SizedBox(width: TSizes.spaceBtwItems),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                    text: TTexts.privacyPolicy,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.white : TColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? TColors.white : TColors.primary,
                    ),
                  ),
                  TextSpan(text: ' ${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                    text: TTexts.termsOfUse,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.white : TColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? TColors.white : TColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: ()=> Get.to(()=> const VerifyEmailScreen()),
            child: const Text(TTexts.createAccount),
          ),
        ),
      ],
    );
  }
}
