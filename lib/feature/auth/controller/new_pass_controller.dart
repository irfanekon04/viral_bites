import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';

import '../../../core/common/widgets/custom_button.dart';
import '../../../core/utils/constants/icon_path.dart';
import '../../../routes/app_routes.dart';

class NewPassController extends GetxController {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxBool isPassVisible = false.obs;
  final resetPassFormKey = GlobalKey<FormState>();
  void togglePasswordVisibility() {
    isPassVisible.value = !isPassVisible.value;
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
