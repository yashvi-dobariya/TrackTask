import 'package:flutter/material.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';

class CustomTextField extends StatelessWidget{
  const CustomTextField({super.key, this.keyboardType, required this.hintText, this.suffixIcon, this.prefixIcon, this.hintStyle, required this.controller, this.onChanged});
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90*w,
      height: 8*h,
      decoration: const BoxDecoration(
        color: AppConst.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextFormField(
        keyboardType:keyboardType,
        controller: controller,
        cursorHeight: 25,
        onChanged: onChanged,
        style: appstyle(16,AppConst.grey.shade800, FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: AppConst.grey.shade800,
          hintStyle: hintStyle,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.red,width: 0.5)
          ),

            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent,width: 0.5)
            ),

            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: AppConst.red,width: 0.5)
            ),

            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: AppConst.grey,width: 0.5)
            ),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: AppConst.grey.shade800,width: 0.5)
            )
        ),
      ),
    );
  }}