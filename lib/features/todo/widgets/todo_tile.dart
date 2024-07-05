import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/reusable_text.dart';

import '../controllers/todo/todo_provider.dart';

class ToDoTile extends ConsumerWidget {
  const ToDoTile({super.key, this.color, this.title, this.description, this.start, this.end, this.editWidget, this.delete, this.switcher});
  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final void Function()? delete;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    dynamic color=ref.read(todoStateProvider.notifier).getRandomColor();
    return Padding(
      padding:  EdgeInsets.only(bottom: 1*h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(2.5*w),
            decoration: BoxDecoration(
              color: AppConst.grey.shade600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 10*h,
                  width: 1.5*w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      // add dynamic colour
                      color: color
                  ),
                ),

                SizedBox(width: 5*w),

                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: title??"Title of ToDo",
                          style: appstyle(18, AppConst.white, FontWeight.bold)
                      ),

                      SizedBox(height:1*h),

                      ReusableText(
                          text: description??"Description of ToDo",
                          style: appstyle(12, AppConst.white, FontWeight.normal)
                      ),

                      SizedBox(height: 1*h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: AppConst.grey.shade800,
                              border: Border.all(width: 0.1*w,color: AppConst.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 3*w,vertical: 0.3*h),
                              child: ReusableText(
                                  text: "$start | $end",
                                  style: appstyle(12, AppConst.white, FontWeight.normal)),
                            )),
                          ),

                          SizedBox(width: 5*w,),
                          SizedBox(
                            child: editWidget,
                          ),
                          SizedBox(width: 3*w),
                          GestureDetector(
                            onTap: delete,
                            child: const Icon(Icons.delete,color: AppConst.white,size: 23),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  child: switcher,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
