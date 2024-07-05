import 'package:flutter/material.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/custom_outline_btn.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/features/auth/page/login_page.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: AppConst.grey.shade800,
        height: 100*h, // Assuming you have a SizeConfig class to calculate screen dimensions
        width: 100*w,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/todo.png"),
            SizedBox(height: 3*h),
            CustomOtlnBtn(
              width: 88*w,
              height: 6.5*h,
                buttonBorderColor: AppConst.white,
                onPress: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder:(context)=>const LoginPage()));
                },
                buttonName:"Login with a Phone number",
            )
          ],
        ),
      ),
    );
  }
}
