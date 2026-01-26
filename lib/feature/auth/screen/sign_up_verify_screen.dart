import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:viral_bites/core/common/widgets/custom_button.dart';
import 'package:viral_bites/core/utils/constants/icon_path.dart';
import 'package:viral_bites/feature/auth/controller/sign_up_verify_controller.dart';
import '../../../core/utils/constants/app_colors.dart';

class SignUpVerifyScreen extends StatelessWidget {
  SignUpVerifyScreen({super.key});
  final controller = Get.put(SignUpVerifyController());

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      height: 60,
      width: 60,
      textStyle: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: .w600,
        color: AppColors.textPrimary,
        backgroundColor: AppColors.textWhite,
      ),
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        color: AppColors.textWhite,
        border: .all(color: Color(0xffE5E7EC)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackGround,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(IconPath.back),
          ),
        ),
        title: Text(
          'Verification Code',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: .w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: .fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Gap(48),
            Padding(
              padding: .symmetric(horizontal: 16),
              child: Text(
                'Enter the verification code that we have sent to your email',
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
              child: Pinput(
                length: 6,
                controller: controller.otpController,
                defaultPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFE3E3E9), width: 2),
                  ),
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 2),
                    color: AppColors.textWhite,
                    borderRadius: .circular(12),
                  ),
                ),
              ),
            ),
            Gap(20),
            Obx(
              () => controller.canResend.value
                  ? TextButton(
                      onPressed: controller.resendOtp,
                      child: Text("Resend OTP"),
                    )
                  : Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          'Resend code in ',
                          textAlign: .center,
                          style: GoogleFonts.inter(
                            fontWeight: .w400,
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '0:${controller.secondsLeft.value}',
                          style: GoogleFonts.poppins(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: .w500,
                          ),
                        ),
                      ],
                    ),
            ),
            Spacer(),
            Obx(
              () => controller.isLoading.value
                  ? SpinKitCircle(color: AppColors.primary)
                  : CustomButton(
                      text: 'Continue',
                      onPressed: () {
                        controller.signUpVerify();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
