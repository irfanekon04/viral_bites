import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viral_bites/core/services/api_service.dart';
import 'package:viral_bites/core/utils/constants/app_urls.dart';
import 'package:viral_bites/feature/auth/screen/new_pass_screen.dart';

import '../../../core/services/storage_service.dart';

class PassVerifyController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  late String mail = Get.arguments;
  static const int _initialSeconds = 60;
  RxBool isLoading = false.obs;
  RxInt secondsLeft = _initialSeconds.obs;
  RxBool canResend = false.obs;
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

  void verify() async {
    final otp = otpController.text;

    try {
      isLoading.value = true;
      final response = await ApiService().postRequest(AppUrls.forgotPassOtp, {
        'email': mail,
        'otp': otp,
      });
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        final Map<String, dynamic> body = jsonDecode(response.body);
        Get.snackbar('Success', 'OTP Verification successful');
        final String? resetToken = body['resetToken'];
        if (resetToken != null) {
          await StorageService().saveData('resetToken', resetToken);
          if (kDebugMode) print("Reset token saved: $resetToken");
        }
        if (kDebugMode) {
          print(response.body);
        }
        Get.to(() => NewPassScreen(), arguments: mail);
      } else {
        Get.snackbar('Error', 'Verification failed: Invalid OTP');
        if (kDebugMode) {
          print(otp);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred!');
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
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
        'email': mail,
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
  }
}
