import 'package:flutter/material.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/reusable_text.dart';

class CustomOtlnBtn extends StatelessWidget{

  const CustomOtlnBtn({super.key, required this.width, required this.height, this.buttonColor, required this.buttonBorderColor, required this.onPress, required this.buttonName});

  final VoidCallback onPress;
  final double width;
  final double height;
  final Color? buttonColor;
  final Color buttonBorderColor;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(width: 1,color:buttonBorderColor),
        ),
        child: Center(
          child: ReusableText(
              text: buttonName,
              style: appstyle(16,buttonBorderColor,FontWeight.bold)),
        ),
      ),
    );
  }}