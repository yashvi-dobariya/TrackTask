import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/custom_outline_btn.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/show_dialogue.dart';
import 'package:todo/features/auth/controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  final TextEditingController phoneControl=TextEditingController();

  sendCodeToUser(){
    if(phoneControl.text.isEmpty)
      {
        return showAlertDialog(
            context: context,
            message: "Enter your phone number");
      }
    else if(phoneControl.text.length<8){
      return showAlertDialog(
          context: context,
          message: "Enter valid phone number");
    }
    else
      {
        ref.read(authControllerProvider).sentSms(context: context, phone: phoneControl.text);
       // phone: '+${ref.read(codeStateProvider)}${phoneControl.text}'
      }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 5*w,right: 5*w),
            child: ListView(
              children: [
                Image.asset("assets/images/todo.png"),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 1*w),
                  child: ReusableText(
                      text: "Please Enter your phone number",
                      style: appstyle(16, AppConst.white, FontWeight.w600)),
                ),

                SizedBox(height: 3*h),

                IntlPhoneField(
                    showCursor: true,
                    style: appstyle(15, AppConst.grey.shade800, FontWeight.normal),
                    decoration:  InputDecoration(
                      focusedBorder:  OutlineInputBorder(
                          borderRadius:const BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: AppConst.grey.shade800,width: 0.5)
                      ),
                    hintText: 'Phone Number',
                    hintStyle: appstyle(15, AppConst.grey.shade500, FontWeight.normal),
                    filled: true,
                    fillColor: AppConst.white,
                    border: const OutlineInputBorder(
                      borderRadius:BorderRadius.all(Radius.circular(12.0)),
                    ),
                    errorStyle: const TextStyle(color: AppConst.white,),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    setState(() {
                      //ref.read(codeStateProvider.notifier).setStart(phone.completeNumber);
                      phoneControl.text = phone.completeNumber; // Assign the phone number to the TextEditingController
                    });
                  },
                ),

                // CustomTextField(
                //   prefixIcon: Container(
                //     padding: EdgeInsets.all(4),
                //     child: GestureDetector(
                //       onTap: (){},
                //       child: ReusableText(text: "+1", style: appstyle(13, AppConst.grey.shade500, FontWeight.normal)),
                //     ),
                //   ),
                //   hintText: "Enter phone number",
                //   controller: phone,
                //   keyboardType: TextInputType.phone,
                //   //prefixIcon: Icon(Icons.phone),
                //   hintStyle: appstyle(13, AppConst.grey.shade500, FontWeight.normal),),

                 SizedBox(height: 3*h),
                CustomOtlnBtn(
                  width: 88*w,
                  height: 6.5*h,
                  buttonBorderColor: AppConst.black,
                  buttonColor: AppConst.white,
                  onPress: (){
                    sendCodeToUser();
                  },
                  buttonName:"Send Code",
                )
              ],
            ),
          )),
    );
  }
}



