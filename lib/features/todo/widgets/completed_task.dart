import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/common/model/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo/features/todo/widgets/todo_tile.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<TaskModel> listData= ref.watch(todoStateProvider);
    List lastMonth= ref.read(todoStateProvider.notifier).last30days();
    var completedList=listData.where((element) => element.isCompleted==1 || lastMonth.contains(element.date!.substring(0,10))).toList();
    dynamic color=ref.read(todoStateProvider.notifier).getRandomColor();

    return ListView.builder(
      itemCount:completedList.length,
      itemBuilder:(context,index){
        final data=completedList[index] ;
        return ToDoTile(
          title:data.title,
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
          color: color,
          editWidget: const SizedBox.shrink(),
          switcher: Icon(Icons.task_alt,color: AppConst.green.shade200),
          delete: (){
            ref.read(todoStateProvider.notifier).deleteTodo(data.id??0);
          },
        );
      },
    );
  }
}