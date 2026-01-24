import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:viral_bites/core/common/widgets/custom_button.dart';
import 'package:viral_bites/core/common/widgets/custom_textformfield.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';
import 'package:viral_bites/core/utils/constants/icon_path.dart';
import 'package:viral_bites/feature/auth/controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackGround,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                InkWell(
                  child: Image.asset(IconPath.back, height: 24, width: 24),
                  onTap: () {
                    Get.back();
                  },
                ),
                Gap(20),
                Text(
                  'Create Your Account',
                  style: GoogleFonts.poppins(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: .w600,
                  ),
                ),
                Text(
                  'Let\'s get started by creating account',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                Gap(32),
                Form(
                  key: _controller.signupFormKey,
                  child: Column(
                    children: [
                      CustomTextformfield(
                        hintText: 'Enter your full name',
                        isObscure: false,
                        headertext: 'Full Name',
                        fillColor: AppColors.textWhite,
                        prefixIcon: Container(
                          height: 15,
                          width: 15,
                          padding: .all(12),
                          child: Image.asset(IconPath.user),
                        ),
                        suffixWidget: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          if (!GetUtils.isAlphabetOnly(value)) {
                            return 'Please enter a valid full name ';
                          }
                          return null;
                        },
                        hintTextColor: AppColors.textSecondary,
                        textController: _controller.nameController,
                        textColor: AppColors.textPrimary,
                      ),
                      Gap(20),
                      CustomTextformfield(
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
                        textController: _controller.emailController,
                        textColor: AppColors.textPrimary,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      Gap(20),
                      CustomTextformfield(
                        hintText: 'xxxxxxxxxxx',
                        isObscure: false,
                        headertext: 'Phone Number',
                        fillColor: AppColors.textWhite,
                        prefixIcon: Container(
                          height: 15,
                          width: 15,
                          padding: .all(12),
                          child: Image.asset(IconPath.phone),
                        ),
                        suffixWidget: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!GetUtils.isPhoneNumber(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        hintTextColor: AppColors.textSecondary,
                        textController: _controller.phoneController,
                        textColor: AppColors.textPrimary,
                      ),
                      Gap(20),
                      Obx(
                        () => CustomTextformfield(
                          hintText: '**********',
                          isObscure: !_controller.isPassVisible.value,
                          headertext: 'Password',
                          fillColor: AppColors.textWhite,
                          prefixIcon: Container(
                            height: 15,
                            width: 15,
                            padding: .all(12),
                            child: Image.asset(IconPath.pass),
                          ),
                          suffixWidget: IconButton(
                            onPressed: _controller.togglePasswordVisibility,
                            icon: Icon(
                              _controller.isPassVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                            ),
                          ),

                          hintTextColor: AppColors.textSecondary,
                          textController: _controller.passController,
                          textColor: AppColors.textPrimary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                        ),
                      ),
                      Gap(20),
                      Obx(
                        () => CustomTextformfield(
                          hintText: '**********',
                          isObscure: !_controller.isConfirmPassVisible.value,
                          headertext: 'Confirm Password',
                          fillColor: AppColors.textWhite,
                          prefixIcon: Container(
                            height: 15,
                            width: 15,
                            padding: .all(12),
                            child: Image.asset(IconPath.pass),
                          ),
                          suffixWidget: IconButton(
                            onPressed:
                                _controller.toggleConfirmPasswordVisibility,
                            icon: Icon(
                              _controller.isConfirmPassVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                            ),
                          ),

                          hintTextColor: AppColors.textSecondary,
                          textController: _controller.confirmPassController,
                          textColor: AppColors.textPrimary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(20),
                Row(
                  mainAxisAlignment: .start,
                  children: [
                    Obx(
                      () => Checkbox(
                        side: const BorderSide(
                          color: AppColors.textSecondary,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: AppColors.primary,
                        value: _controller.agreeTerms.value,
                        onChanged: (value) {
                          _controller.agreeTerms.value =
                              !_controller.agreeTerms.value;
                        },
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Agree to the Terms of service and Privacy policy.',
                        style: (GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        )),
                      ),
                    ),
                  ],
                ),
                Gap(32),
                CustomButton(
                  text: 'Register',
                  onPressed: () {
                    _controller.signup();
                  },
                ),
                Gap(32),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: .w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        " Log In",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w400,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
