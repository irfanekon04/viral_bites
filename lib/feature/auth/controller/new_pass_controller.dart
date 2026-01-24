import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/core/services/api_service.dart';
import 'package:viral_bites/core/services/storage_service.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';
import 'package:viral_bites/core/utils/constants/app_urls.dart';

import '../../../core/common/widgets/custom_button.dart';
import '../../../core/utils/constants/icon_path.dart';
import '../../../routes/app_routes.dart';

class NewPassController extends GetxController {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxBool isPassVisible = false.obs;
  RxBool isConfirmPassVisible = false.obs;

  final resetPassFormKey = GlobalKey<FormState>();
  void togglePasswordVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPassVisible.value = !isConfirmPassVisible.value;
  }

  void verifyResetPass() async {
    final password = confirmPassController.text;
    final email = Get.arguments;
    try {
      final resetToken = StorageService().getData('resetToken');
      if (resetToken == null || resetToken.isEmpty) {
        if (kDebugMode) {
          print('Reset token not found');
        }
        return;
      }
      final response = await ApiService().postRequest(AppUrls.resetPass, {
        'email': email,
        'resetToken': resetToken,
        'newPassword': password,
      });
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'OTP Verification successful');
        if (kDebugMode) {
          print(response.body);
        }
        showSuccessPopup();
      } else {
        Get.snackbar('Error', 'Verification failed: Invalid OTP');
        if (kDebugMode) {
          print(response.body);
        }
        if (kDebugMode) {
          print(resetToken);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred!');
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void showSuccessPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.textWhite,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(IconPath.successicon, height: 120),
              const SizedBox(height: 20),
              Text(
                "Password Changed",
                textAlign: .center,
                style: GoogleFonts.inter(
                  fontWeight: .w500,
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
              ),
              Gap(20),
              Text(
                "Password changed successfully, you can login again with new password.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                text: "Back to Log in",
                onPressed: () {
                  Get.back();
                  Get.offAllNamed(AppRoutes.signIn);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
