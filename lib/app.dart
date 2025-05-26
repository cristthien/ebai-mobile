import 'package:ebai/utils/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:ebai/utils/theme/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      // initialBinding: GeneralBindings(),
      home: const Scaffold( backgroundColor: TColors.primary,body: Center(child: CircularProgressIndicator(color: TColors.white)),)
    );
  }
}
