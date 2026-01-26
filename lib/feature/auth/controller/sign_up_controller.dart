import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viral_bites/core/services/api_service.dart';
import 'package:viral_bites/core/utils/constants/app_urls.dart';
import 'package:viral_bites/feature/auth/screen/sign_up_verify_screen.dart';

class SignUpController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxBool agreeTerms = false.obs;
  RxBool isLoading = false.obs;
  RxBool isPassVisible = false.obs;
  RxBool isConfirmPassVisible = false.obs;
  void toogleCheckbox() {
    agreeTerms.value = !agreeTerms.value;
  }

  void togglePasswordVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPassVisible.value = !isConfirmPassVisible.value;
  }

  void signup() async {
    if (!agreeTerms.value) {
      Get.snackbar('Sorry', 'You must agree to terms and policy');
      return;
    }
    if (signupFormKey.currentState!.validate()) {
      final fullName = nameController.text.trim();
      final email = emailController.text.trim();
      final phone = phoneController.text.trim();
      final password = passController.text;
      final termsNcond = agreeTerms.value;

      try {
        isLoading.value = true;
        final response = await ApiService().postRequest(AppUrls.signup, {
          'fullName': fullName,
          'email': email,
          'phoneNumber': phone,
          'password': password,
          'agreeTermsAndPolicy': termsNcond,
        });
        if (response.statusCode == 201) {
          Get.snackbar('Success', 'Verify your phone number.');
          if (kDebugMode) {
            print(response.body);
          }
          Get.to(() => SignUpVerifyScreen(), arguments: email);
        } else {
          Get.snackbar('Error', 'Signup failed!');
          if (kDebugMode) {
            print(response.body);
          }
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred!');
        if (kDebugMode) {
          print(e);
        }
      }
      finally{
        isLoading.value = false;
      }
    }
  }
}
