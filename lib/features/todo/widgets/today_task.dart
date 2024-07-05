import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/model/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/show_dialogue.dart';
import 'package:todo/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo/features/todo/page/update_task.dart';
import 'package:todo/features/todo/widgets/todo_tile.dart';

class TodayTask extends ConsumerWidget {
  const TodayTask({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<TaskModel> listData= ref.watch(todoStateProvider);
    String today= ref.read(todoStateProvider.notifier).getToday();
    var todayList=listData.where((element) => element.isCompleted==0 &&element.date!.contains(today)).toList();

    return ListView.builder(
      itemCount:todayList.length,
      itemBuilder:(context,index){
        final data=todayList[index] ;
        bool isCompleted=ref.read(todoStateProvider.notifier).getStatus(data);

        return ToDoTile(
          title:data.title,
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
          editWidget:  InkWell(
              onTap:(){
                titles=data.title.toString();
                descs=data.desc.toString();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(id:data.id??0)));
              },
              child: const Icon(Icons.edit_note,color: AppConst.white,size: 30)),
          switcher: Switch(
              value: isCompleted,
              onChanged: (value){
                ref.read(todoStateProvider.notifier).markAsCompleted(
                    data.id??0,
                    data.title.toString(),
                    data.desc.toString(),
                    1,
                    data.date.toString(),
                    data.startTime.toString(),
                    data.endTime.toString());

        showAlertDialog(
        context: context,
        message: " your task is completed !!");
              }),
          delete: (){
            ref.read(todoStateProvider.notifier).deleteTodo(data.id??0);
          },
        );
      },
    );
  }
}