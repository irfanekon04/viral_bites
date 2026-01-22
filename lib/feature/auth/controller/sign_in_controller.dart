import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viral_bites/feature/home/screen/home_screen.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  RxBool isChecked = false.obs;
  RxBool isPassVisible = false.obs;

  void togglePasswordVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  void toogleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(HomeScreen());
    }
  }
}
