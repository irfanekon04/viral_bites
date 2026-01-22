import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextformfield extends StatelessWidget {
  final Color? fillColor;
  final String? hintText;
  final String? headertext;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? isObscure;
  final Widget? prefixIcon;
  final Widget? suffixWidget;
  final TextEditingController? textController;
  final String? Function(String?)? validator;

  const CustomTextformfield({
    super.key,
    this.fillColor,
    required this.hintText,
    this.hintTextColor,
    required this.isObscure,
    required this.headertext,
    this.textColor,
    this.prefixIcon,
    this.suffixWidget,
    this.textController,
    this.validator
  });

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: .circular(10),
      borderSide: BorderSide(color: Color(0xFFE5E7EC), width: 1),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: fillColor,
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: GoogleFonts.inter(
        color: hintTextColor,
        fontSize: 14,
        fontWeight: .normal,
      ),
      suffix: suffixWidget,
      border: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      disabledBorder: _outlineInputBorder(),
      errorBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      focusedErrorBorder: _outlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            headertext!,
            style: GoogleFonts.inter(
              color: textColor,
              fontSize: 14,
              fontWeight: .w500,
            ),
          ),
          Gap(10),
          TextFormField(
            controller: textController,
            obscureText: isObscure!,
            decoration: _inputDecoration(),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
