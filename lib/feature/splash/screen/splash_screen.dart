import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';
import 'package:viral_bites/feature/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  // ignore: unused_field
  final _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFECEB),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Image.asset('assets/logos/logo.png', height: 257, width: 232),
              Spacer(),
              SpinKitCircle(color: AppColors.primary),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
