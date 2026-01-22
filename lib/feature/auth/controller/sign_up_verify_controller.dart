import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/core/common/widgets/custom_button.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';
import 'package:viral_bites/core/utils/constants/icon_path.dart';

import '../../../routes/app_routes.dart';

class SignUpVerifyController extends GetxController {
  RxString otpText = "".obs;
  void verify() {}
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
}
