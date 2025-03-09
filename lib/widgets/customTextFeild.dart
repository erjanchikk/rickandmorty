import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    super.key,
    required this.controller,
    this.obscureText,
    required this.text,
     this.onPressed,
  });
  final Function()? onPressed;
  final bool ?obscureText;
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.r,
      width: 319.r,
      child: TextField(
        obscureText: obscureText??false,
        decoration: InputDecoration(
          
          hintText: text,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.r,
          ),
          prefixIcon: obscureText!=null
              ? const Icon(Icons.lock_outline)
              : const Icon(Icons.person_2_outlined),
          filled: true,
          fillColor: Color(0xffF2F2F2),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
          suffixIcon: obscureText!=null
              ? IconButton(
                  onPressed: onPressed,
                  icon: Icon(obscureText!
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye))
              : null,
        ),
        controller: controller,
      ),
    );
  }
}