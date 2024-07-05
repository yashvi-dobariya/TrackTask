import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/common/model/task_model.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/utils/size_config.dart';
import 'package:todo/common/widgets/appstyle.dart';
import 'package:todo/common/widgets/custom_textfield.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/xpansion_tile.dart';
import 'package:todo/features/todo/controllers/todo/todo_provider.dart';
import 'package:todo/features/todo/controllers/xpansion_provider.dart';
import 'package:todo/features/todo/page/add.dart';
import 'package:todo/features/todo/widgets/completed_task.dart';
import 'package:todo/features/todo/widgets/day_after_tomorrow.dart';
import 'package:todo/features/todo/widgets/today_task.dart';
import 'package:todo/features/todo/widgets/todo_tile.dart';
import 'package:todo/features/todo/widgets/tomorrow_list.dart';

class HomePage extends ConsumerStatefulWidget{
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() =>_HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin{

  late final TabController tabController=TabController(length: 2, vsync: this);
  TextEditingController searchControl=TextEditingController();



  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        bottom:  PreferredSize(
          preferredSize: Size.fromHeight(10*h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4*w,right: 4*w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                  ReusableText(
                      text: "DashBoard",
                      style:appstyle(18, AppConst.white, FontWeight.bold)),

                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddTask()));
                        },
                        child: const Icon(Icons.add_box,color: AppConst.white)),
                  ],
                ),
              ),
              SizedBox(height:3*h),

              CustomTextField(
                  hintText: "Search...",
                  hintStyle:appstyle(16, AppConst.grey.shade600, FontWeight.normal),
                  controller: searchControl,
                  prefixIcon:  InkWell(
                  onTap: null,
                  child: Icon(FontAwesomeIcons.searchengin,color: AppConst.grey.shade800),
                ),
                suffixIcon: Icon(FontAwesomeIcons.sliders,size: 20,color: AppConst.grey.shade800),
              )
            ],
          ),
        ),
      ),

      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 4*w,right: 4*w),
            child: ListView(
              children: [
                SizedBox(height: 6*h),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.listCheck,color: AppConst.white,size: 18),
                    SizedBox(width: 3*w),
                    ReusableText(
                        text: "Today's Task",
                        style: appstyle(18, AppConst.white, FontWeight.bold))
                  ],
                ),
                SizedBox(height: 4*h),

                Container(
                  decoration: BoxDecoration(
                    color: AppConst.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: tabController,
                    labelPadding: EdgeInsets.zero,
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      color: AppConst.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tabs: [
                      Tab(
                        child: Center(
                          child: ReusableText(
                            text: 'Pending',
                            style: appstyle(16, AppConst.grey.shade800, FontWeight.bold),),
                        )
                      ),

                      Tab(
                          child: Center(
                            child: ReusableText(
                              text: 'Completed',
                              style: appstyle(16, AppConst.grey.shade800, FontWeight.bold),),
                          )
                      ),
                      // Tab(
                      //     child: Container(
                      //       padding: EdgeInsets.only(left: 5*w),
                      //         child:  Center(
                      //           child: ReusableText(
                      //             text: 'Completed',
                      //             style: appstyle(16, AppConst.grey.shade800, FontWeight.bold),),
                      //         )
                      //     )
                      // ),
                    ],
                  ),
                ),

                SizedBox(height: 2*h),

                SizedBox(
                  height: 25*h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Container(
                          color: AppConst.grey,
                          child: const TodayTask(),
                        ),
                        Container(
                          color: AppConst.grey,
                          child: const CompletedTask(),
                        ),
                      ],),),
                ),

                SizedBox(height: 3*h),

                const TomorrowList(),

                // XpansionTile(
                //     text: "Tomorrow's Task",
                //     text2: "Tomorrow's tasks are shown here",
                //     onExpansionChanged: (bool expanded){
                //       ref.read(xpansionStateProvider.notifier).setStart(!expanded);
                //     },
                //     trailing: Padding(
                //       padding:  EdgeInsets.only(right: 1*w),
                //       child: ref.watch(xpansionStateProvider)?Icon(Icons.keyboard_arrow_down,color:AppConst.white):Icon(Icons.keyboard_arrow_up,color:AppConst.white),
                //     ),
                //     children: [
                //       ToDoTile(
                //           start:"9:00",
                //           end: "8:12",
                //           switcher: Switch(
                //               value: true,
                //               onChanged: (value){})),
                //     ]),

                SizedBox(height: 3*h),
                 const DayAfterTomorrow(),
                 // XpansionTile(
                 //    text: DateTime.now().add(Duration(days:2)).toString().substring(5,10),
                 //    text2: "Day After tomorrow's tasks",
                 //     onExpansionChanged: (bool expanded){
                 //       ref.read(xpansionState0Provider.notifier).setStart(!expanded);
                 //     },
                 //     trailing: Padding(
                 //       padding:  EdgeInsets.only(right: 1*w),
                 //       child: ref.watch(xpansionState0Provider)?Icon(Icons.keyboard_arrow_down,color:AppConst.white):Icon(Icons.keyboard_arrow_up,color:AppConst.white),
                 //     ),
                 //    children:  [
                 //      ToDoTile(
                 //          start:"9:00",
                 //          end: "8:12",
                 //          switcher: Switch(
                 //              value: true,
                 //              onChanged: (value){})),
                 //
                 //    ]),
              ],
            ),
          ))
    );
  }}


