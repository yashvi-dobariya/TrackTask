import 'package:flutter/material.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/reusable_text.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: AppConst.grey.shade800,
        height: 100 * h, // Assuming you have a SizeConfig class to calculate screen dimensions
        width: 100* w,
        child:  Padding(
          padding: EdgeInsets.only(left: 5*w,right: 5*w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/todo.png"),
              SizedBox(height: 3*h),
               Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReusableText(
                      text: "Manage your Task",
                      style: appstyle(26, AppConst.white, FontWeight.w600),),
                    SizedBox(height: 2*h),
                  Text("Welcome !!  Do you want to create a task fast and with ease ?",
                     textAlign: TextAlign.center,
                     style: appstyle(16, AppConst.grey.shade400, FontWeight.normal),)
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
