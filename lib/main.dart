import 'package:ebai/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import 'data/repositories/authentication_repository.dart';
import 'data/services/health-services.dart';



/// -- Entry point of Flutter App
Future<void> main() async {

  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  /// -- GetX Local Storage
  await GetStorage.init();
  /// -- Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // print('Checking database health...');
  // try {
  //   final healthService = HealthService();
  //   final healthStatus = await healthService.checkDatabaseHealth();
  //   Get.put(AuthenticationRepository());
  //
  // }catch(e){
  //   print(e);
  //   return;
  // }
  Get.put(AuthenticationRepository());
  runApp(const App());
}
