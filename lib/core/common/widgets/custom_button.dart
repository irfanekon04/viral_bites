import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: isOutlined ? Colors.white : AppColors.primary,
          foregroundColor: AppColors.textWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isOutlined
                ? BorderSide(color: AppColors.primary)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
