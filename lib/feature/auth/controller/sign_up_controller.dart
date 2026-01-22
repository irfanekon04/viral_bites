import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
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

}
