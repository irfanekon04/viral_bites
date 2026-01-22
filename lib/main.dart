import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:viral_bites/core/utils/constants/app_colors.dart';
import 'package:viral_bites/routes/app_routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.init,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryBackGround,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
    ),
  );
}
