import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/features/auth/controllers/auth_controller.dart';

class OtpPage extends ConsumerWidget{
   OtpPage({super.key, required this.smsCodeId, required this.phone});
   final String smsCodeId;
   final String phone;

   void verifyOtpCode(BuildContext context,WidgetRef ref,String smsCode ){
     ref.read(authControllerProvider).verifyOtpCode(
         context: context,
         smsCodeId: smsCodeId,
         smsCode: smsCode,
         mounted: true);
   }

  final TextEditingController pinController=TextEditingController();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body:  SafeArea(
          child: Center(
            child: Padding(
              padding:  EdgeInsets.only(left: 5*w,right: 5*w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5*h),
                  Image.asset("assets/images/todo.png"),
                  ReusableText(
                      text: "Enter your OTP",
                      style:appstyle(16, AppConst.white, FontWeight.w600)),
                  SizedBox(height: 2*h),
                   Pinput(
                    length: 6,
                    showCursor: true,
                    onCompleted: (value){
                      if(value.length==6){
                        return verifyOtpCode(context, ref, value);
                      }
                    },
                     onSubmitted: (value){
                       if(value.length==6){
                         return verifyOtpCode(context, ref, value);
                       }
                     },
                  )
                ],
              ),
            ),
          )),
    );
  }
}

