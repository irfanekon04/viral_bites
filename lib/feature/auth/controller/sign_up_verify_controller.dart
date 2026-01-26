import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/core/common/widgets/custom_button.dart';
import 'package:viral_bites/core/services/api_service.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';
import 'package:viral_bites/core/utils/constants/icon_path.dart';

import '../../../core/utils/constants/app_urls.dart';
import '../../../routes/app_routes.dart';

class SignUpVerifyController extends GetxController {
  late String email = Get.arguments;
  TextEditingController otpController = TextEditingController();
  static const int _initialSeconds = 60;
  RxInt secondsLeft = _initialSeconds.obs;
  RxBool canResend = false.obs;
  RxBool isLoading = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void signUpVerify() async {
    final otpCode = otpController.text;

    try {
      isLoading.value = true;
      final response = await ApiService().postRequest(AppUrls.signUpOtpVerify, {
        'email': email,
        'otp': otpCode,
      });
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Verification Successful!');
        showSuccessPopup();
      } else {
        Get.snackbar('Error', 'Invalid OTP');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred!');
    }
    finally{
      isLoading.value = false;
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
                "Account Verified Successfully",
                // "dsaf",
                textAlign: .center,
                style: GoogleFonts.inter(
                  fontWeight: .w500,
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "Continue",
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

  void startTimer() {
    canResend.value = false;
    secondsLeft.value = _initialSeconds;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value == 0) {
        canResend.value = true;
        timer.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;

    try {
      final response = await ApiService().postRequest(AppUrls.forgotPassOtp, {
        'email': email,
      });

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'OTP resent');
        startTimer();
      } else {
        Get.snackbar('Error', 'Failed to resend OTP');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
    finally{
      isLoading.value = false;
    }
  }
}
