import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:viral_bites/core/services/fcm_service.dart';
import 'package:viral_bites/core/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';
import 'package:viral_bites/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmService().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.init,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryBackGround,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
    );
  }
}
