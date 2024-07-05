import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/xpansion_tile.dart';
import 'package:todo/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo/features/todo/controllers/xpansion_provider.dart';
import 'package:todo/features/todo/page/update_task.dart';
import 'package:todo/features/todo/widgets/todo_tile.dart';

class DayAfterTomorrow extends ConsumerWidget {
  const DayAfterTomorrow({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final todos=ref.watch(todoStateProvider);
    dynamic color=ref.read(todoStateProvider.notifier).getRandomColor();
    String dayAfterTomorrow=ref.read(todoStateProvider.notifier).getDayAfterTomorrow();
    var tomorrowTasks=todos.where((element) => element.date!.contains(dayAfterTomorrow));

    return XpansionTile(
        text: DateTime.now().add(const Duration(days:2)).toString().substring(5,10),
        text2: "Day After tomorrow's tasks",
        onExpansionChanged: (bool expanded){
          ref.read(xpansionStateProvider.notifier).setStart(!expanded);
        },
        trailing: Padding(
          padding:  EdgeInsets.only(right: 1*w),
          child: ref.watch(xpansionStateProvider)?const Icon(Icons.keyboard_arrow_down,color:AppConst.white):const Icon(Icons.keyboard_arrow_up,color:AppConst.white),
        ),
        children: [
          for(final todo in tomorrowTasks)
            ToDoTile(
              title: todo.title,
              start:todo.startTime,
              end: todo.endTime,
              description: todo.desc,
              color: color,
              delete: (){
                ref.read(todoStateProvider.notifier).deleteTodo(todo.id??0);
              },
              editWidget:  InkWell(
                  onTap:(){
                    titles=todo.title.toString();
                    descs=todo.desc.toString();

                    Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(id:todo.id??0)));
                  },child: const Icon(Icons.edit_note,color: AppConst.white,size: 30)),
              switcher: const SizedBox.shrink(),

            ),
        ]);
  }
}
