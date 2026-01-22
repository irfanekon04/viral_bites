import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool isChecked = false.obs;
  RxBool isPassVisible = false.obs;

  void togglePasswordVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  void toogleCheckbox() {
    isChecked.value = !isChecked.value;
  }

}
