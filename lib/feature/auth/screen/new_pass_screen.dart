import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/core/common/widgets/custom_button.dart';
import 'package:viral_bites/feature/auth/controller/new_pass_controller.dart';
import '../../../core/common/widgets/custom_textformfield.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/icon_path.dart';

class NewPassScreen extends StatelessWidget {
  const NewPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewPassController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                      'Create New Password',
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
                    'Your password must be different from previous used password',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: .w400,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: .center,
                  ),
                ),
                Gap(32),
                Obx(
                  () => CustomTextformfield(
                    hintText: '**********',
                    isObscure: !controller.isPassVisible.value,
                    headertext: 'Password',
                    fillColor: AppColors.textWhite,
                    prefixIcon: Container(
                      height: 15,
                      width: 15,
                      padding: .all(12),
                      child: Image.asset(IconPath.pass),
                    ),
                    suffixWidget: IconButton(
                      onPressed: controller.togglePasswordVisibility,
                      icon: Icon(
                        controller.isPassVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      color: AppColors.textSecondary,
                    ),

                    hintTextColor: AppColors.textSecondary,
                    textController: controller.passController,
                    textColor: AppColors.textPrimary,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid ';
                      }
                      return null;
                    },
                  ),
                ),
                Gap(20),
                Obx(
                  () => CustomTextformfield(
                    hintText: '**********',
                    isObscure: !controller.isConfirmPassVisible.value,
                    headertext: 'Confirm Password',
                    fillColor: AppColors.textWhite,
                    prefixIcon: Container(
                      height: 15,
                      width: 15,
                      padding: .all(12),
                      child: Image.asset(IconPath.pass),
                    ),
                    suffixWidget: IconButton(
                      onPressed: controller.toggleConfirmPasswordVisibility,
                      icon: Icon(
                        controller.isConfirmPassVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      color: AppColors.textSecondary,
                    ),

                    hintTextColor: AppColors.textSecondary,
                    textController: controller.confirmPassController,
                    textColor: AppColors.textPrimary,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid  ';
                      }
                      return null;
                    },
                  ),
                ),
                Gap(32),
                Obx(
                  () => controller.isLoading.value
                      ? SpinKitCircle(color: AppColors.primary)
                      : CustomButton(
                          text: 'Change Password',
                          onPressed: () {
                            controller.verifyResetPass();
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
