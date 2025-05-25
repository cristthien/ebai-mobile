import 'package:ebai/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Column(
      children: [
        Form(
          key: controller.signupFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.username,
                validator: (value) => TValidator.validateUsername(value),
                expands: false,
                decoration: const InputDecoration(labelText: TTexts.userName, prefixIcon: Icon(Iconsax
                    .user)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                expands: false,
                decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax
                    .direct)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
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
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Obx(()=> TextFormField(
                controller: controller.rePassword,
                validator: (value) => TValidator.validatePassword(value),
                obscureText: controller.hidePasswordVerification.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TTexts.rePassword,
                  suffixIcon: IconButton(
                      icon: Icon(controller.hidePasswordVerification.value ? Iconsax.eye_slash : Iconsax.eye),
                      onPressed: () => controller.hidePasswordVerification.value = !controller.hidePasswordVerification.value ),
                ),
              ),),

              const SizedBox(height: TSizes.spaceBtwInputFields),
              // ... more form fields will likely follow here
            ],
          ),
        ),
        /// Terms&Condition Checkbox
        TTermsAndConditionCheckbox(),
        const SizedBox(height: TSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.signup(),
            child: const Text(TTexts.createAccount),
          ),
        ),
      ],
    );
  }
}
