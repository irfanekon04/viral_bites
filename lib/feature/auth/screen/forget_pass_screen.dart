import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/core/common/widgets/custom_button.dart';
import 'package:viral_bites/feature/auth/controller/forget_pass_controller.dart';

import '../../../core/common/widgets/custom_textformfield.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/icon_path.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPassController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(IconPath.back),
                    ),
                  ),
                  Text(
                    'Forgot Password?',
                    style: GoogleFonts.poppins(
                      color: AppColors.textPrimary,
                      fontWeight: .w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
              Gap(48),
              Padding(
                padding: .symmetric(horizontal: 16),
                child: Text(
                  'Enter your email, we will send a verification code to your email',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: .w400,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: .center,
                ),
              ),
              Gap(32),
              Form(
                key: controller.forgotPassFormKey,
                child: CustomTextformfield(
                  hintText: 'Enter your email',
                  isObscure: false,
                  headertext: 'Email Address',
                  fillColor: AppColors.textWhite,
                  prefixIcon: Container(
                    height: 15,
                    width: 15,
                    padding: .all(12),
                    child: Image.asset(IconPath.email),
                  ),
                  suffixWidget: null,
                  hintTextColor: AppColors.textSecondary,
                  textController: controller.emailController,
                  textColor: AppColors.textPrimary,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              Gap(32),
              CustomButton(
                text: 'Send Code',
                onPressed: () {
                  controller.sendOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
