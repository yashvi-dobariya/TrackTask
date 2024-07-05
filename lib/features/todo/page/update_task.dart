import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/model/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/custom_outline_btn.dart';
import 'package:todo/common/widgets/custom_textfield.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:todo/features/todo/controllers/dates/dates_provider.dart';
import 'package:todo/features/todo/controllers/todo/todo_provider.dart';

class UpdateTask extends ConsumerStatefulWidget {
  const UpdateTask({required this.id, super.key});
  final int id;


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<UpdateTask> {

  final TextEditingController title=TextEditingController(text: titles);
  final TextEditingController desc=TextEditingController(text: descs);
  @override
  Widget build(BuildContext context) {

    var scheduleDate=ref.watch(dateStateProvider);
    var start=ref.watch(startTimeStateProvider);
    var finish=ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5*w),
        child: ListView(
          children: [
            SizedBox(height: 2*h),
            CustomTextField(
                hintText: "Add title",
                controller: title,
                hintStyle:appstyle(16, AppConst.grey, FontWeight.normal)),
            SizedBox(height: 2*h),
            CustomTextField(
                hintText: "Add description",
                controller: desc,
                hintStyle:appstyle(16, AppConst.grey, FontWeight.normal)),
            SizedBox(height: 2*h),
            CustomOtlnBtn(
              width: 100*w,
              height: 6.5*h,
              buttonName:scheduleDate== "" ? "set Date" :scheduleDate.substring(0,10),
              buttonBorderColor: AppConst.grey.shade800,
              buttonColor: AppConst.white,
              onPress: (){
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2022, 7, 23),
                    maxTime: DateTime(2025, 7, 23),
                    theme: picker.DatePickerTheme(
                        doneStyle:
                        TextStyle(color: AppConst.green.shade800, fontSize: 16)),
                    onConfirm: (date) {
                      ref.read(dateStateProvider.notifier).setDate(date.toString());
                    },
                    currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
            ),

            SizedBox(height: 2*h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtlnBtn(
                  width: 40*w,
                  height: 6.5*h,
                  buttonBorderColor: AppConst.grey.shade800,
                  buttonColor: AppConst.white,
                  buttonName:start==""?"Start Time":start.substring(10,16),
                  onPress: (){
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        onConfirm: (date) {
                          ref.read(startTimeStateProvider.notifier).setStart(date.toString());
                        },
                        locale: picker.LocaleType.en);
                  },
                ),

                CustomOtlnBtn(
                  width: 40*w,
                  height: 6.5*h,
                  buttonBorderColor: AppConst.grey.shade800,
                  buttonColor: AppConst.white,
                  buttonName:finish==""?"End Time":finish.substring(10,16),
                  onPress: (){
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        onConfirm: (date) {
                          ref.read(finishTimeStateProvider.notifier).setStart(date.toString());
                        },
                        locale: picker.LocaleType.en);
                  },
                ),
              ],
            ),

            SizedBox(height: 2*h),

            CustomOtlnBtn(
              width: 40*w,
              height: 6.5*h,
              buttonBorderColor: AppConst.black,
              buttonColor: AppConst.amber,
              onPress: (){
                if(title.text.isNotEmpty && desc.text.isNotEmpty && scheduleDate.isNotEmpty && start.isNotEmpty && finish.isNotEmpty){

                  ref.read(todoStateProvider.notifier).updateItem(widget.id,title.text,desc.text,0,scheduleDate,start.substring(10,16),finish.substring(10,16));
                  ref.read(finishTimeStateProvider.notifier).setStart('');
                  ref.read(startTimeStateProvider.notifier).setStart('');
                  ref.read(dateStateProvider.notifier).setDate('');
                  Navigator.pop(context);
                }
                else{
                  print('failed to add task');
                }
              },
              buttonName:"submit",),

          ],
        ),
      ),
    );
  }
}

