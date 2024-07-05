import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/features/todo/controllers/todo/todo_provider.dart';

class BottomTitles extends StatelessWidget {

  const BottomTitles({super.key, required this.text, required this.text2,  this.clr});
  final String text;
  final String text2;
  final Color? clr;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(1*w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer(
              builder: (context,ref,child){
                var color=ref.read(todoStateProvider.notifier).getRandomColor();
                return Container(
                  height: 10*h,
                  width: 1.5*w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: color
                  ),
                );
          }),
          SizedBox(width: 5*w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                  text: text,
                  style: appstyle(24, AppConst.white, FontWeight.bold)),
              SizedBox(height: 1*h),
              ReusableText(
                  text: text2,
                  style: appstyle(12, AppConst.white, FontWeight.normal)),
            ],
          )
        ],
      ),
    );
  }
}
