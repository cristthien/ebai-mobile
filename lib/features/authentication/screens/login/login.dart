import 'package:ebai/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ebai/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

import '../../../../common/styles/spacing_styles.dart';
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
                 TLoginForm()]),
        ),
      ),
    );
  }
}


