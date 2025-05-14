import 'package:ebai/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Title
              ///
              Text(TTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),
              /// Form
              SignUpForm(dark: dark)
            ],
          ),
        ),
      ),
    );
  }
}

