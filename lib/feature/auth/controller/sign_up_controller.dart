import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viral_bites/feature/auth/screen/sign_up_verify_screen.dart';

class SignUpController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxBool isChecked = false.obs;
  RxBool isPassVisible = false.obs;
  void toogleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  void togglePasswordVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  void signup() async {
    if (signupFormKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 1));
      Get.to(SignUpVerifyScreen());
    }
  }
}
