import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:viral_bites/core/common/widgets/custom_button.dart';
import 'package:viral_bites/core/common/widgets/custom_textformfield.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';
import 'package:viral_bites/core/utils/constants/icon_path.dart';
import 'package:viral_bites/feature/auth/controller/sign_in_controller.dart';
import 'package:viral_bites/feature/auth/screen/forget_pass_screen.dart';
import 'package:viral_bites/feature/auth/screen/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _controller = Get.put(SignInController());

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
                Gap(46),
                Text(
                  'Hey! Welcome',
                  style: GoogleFonts.poppins(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: .w600,
                  ),
                ),
                Text(
                  'Please enter your login details',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                Gap(32),
                Form(
                  key: _controller.loginFormKey,
                  child: Column(
                    children: [
                      CustomTextformfield(
                        hintText: 'Enter your email address',
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
                            return 'Please enter your email';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      Gap(20),
                      Obx(
                        () => CustomTextformfield(
                          hintText: 'Enter your Password',
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
                            ),
                            color: AppColors.textSecondary,
                          ),
                          hintTextColor: AppColors.textSecondary,
                          textController: _controller.passController,
                          textColor: AppColors.textPrimary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
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
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
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
                            value: _controller.isChecked.value,
                            onChanged: (value) {
                              _controller.toogleCheckbox();
                            },
                          ),
                        ),
                        Text(
                          'Remember Me',
                          style: (GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                          )),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        Get.to(ForgetPassScreen());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.inter(
                          color: AppColors.primary,
                          fontWeight: .w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(32),
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    _controller.login();
                  },
                ),
                Gap(46),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: .w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Text(
                        " Register",
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
