import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:viral_bites/feature/auth/screen/pass_verify_screen.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/constants/app_urls.dart';

class ForgetPassController extends GetxController {
  final forgotPassFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  void sendOtp() async {
    if (forgotPassFormKey.currentState!.validate()) {
      final email = emailController.text.trim();

      try {
        isLoading.value = true;
        final response = await ApiService().postRequest(AppUrls.forgotPass, {
          'email': email,
        });
        if (response.statusCode == 200) {
          Get.snackbar('Success', 'OTP sent to your phone');
          if (kDebugMode) {
            print(response.body);
          }
          Get.to(() => PassVerifyScreen(), arguments: email);
        } else {
          Get.snackbar('Error', 'OTP send failed: Invalid email');
          if (kDebugMode) {
            print(response.body);
          }
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred!');
      }
      finally{
        isLoading.value = false;
      }
    }
  }
}
