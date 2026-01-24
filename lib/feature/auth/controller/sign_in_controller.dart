import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viral_bites/feature/home/screen/home_screen.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/constants/app_urls.dart';

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
      final email = emailController.text.trim();
      final password = passController.text;

      try {
        final response = await ApiService().postRequest(AppUrls.login, {
          'email': email,
          'password': password,
        });
        if (response.statusCode == 200) {
          Get.snackbar('Success', 'Login successful');
          Get.offAll(() => HomeScreen());
        } else {
          Get.snackbar('Error', 'Login failed: Invalid email or password');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred!');
      }
    }
  }
}
