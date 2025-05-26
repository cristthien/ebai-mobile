import 'package:ebai/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'data/local_storage/local_storage.dart';
import 'data/repositories/authentication_repository.dart';
import 'data/socket_service/product_socket_services.dart';


/// -- Entry point of Flutter App
Future<void> main() async {

  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  /// -- GetX Local Storage
  await GetStorage.init();
  /// -- Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await TLocalStorage.init();
  // // 4. LƯU TRỮ JWT VÀO LOCAL STORAGE TRƯỚC KHI ỨNG DỤNG CHẠY
  // const String jwtToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzQ4MjQ4OTYxLCJleHAiOjE3NDgzMzUzNjF9.F9qw1kERC0P6nIWyXYnZLaherl9vYlFqbC80G1h0nRY";
  // const String username = "GiaThien";
  // await TLocalStorage().saveData('access_token', jwtToken);
  // await TLocalStorage().saveData('username', username);
  // await TLocalStorage().saveData('role', 'user');
  // await TLocalStorage().saveData('email', 'cristhuuthien@gmail.com');
  // print('JWT Token has been saved to shared_preferences.');
  Get.put(ProductSocketService());
  // Lấy instance của service
  final productSocketService = Get.find<ProductSocketService>();

  // Gọi initializeSocket và chờ nó hoàn tất
  try {
    await productSocketService.initializeSocket();
    print('Socket initialized and connected successfully from main!');
  } catch (e) {
    print('Failed to initialize socket from main: $e');
  }

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
