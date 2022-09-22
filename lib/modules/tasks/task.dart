import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotoapp/models/taskmodel.dart';
import 'package:dotoapp/modules/tasks/task_item.dart';
import 'package:dotoapp/provider/myprovider.dart';
import 'package:dotoapp/utils/add-task-firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/update-task-bottom-sheet.dart';

class TaskTab extends StatefulWidget {
  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
    return Container(
      child:Column(
    children: [
      CalendarTimeline(
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365)),
        onDateSelected: (date) {
          selectedDate=date;
          setState(() {

          });
        },
        leftMargin: 20,
        monthColor: provider.themmode==ThemeMode.light?Colors.black:Colors.white,
        dayColor: provider.themmode==ThemeMode.light?Colors.black:Colors.white,
        activeDayColor: Theme.of(context).primaryColor,
        activeBackgroundDayColor: Colors.white,
        dotsColor: Theme.of(context).primaryColor,
        selectableDayPredicate: (date) => true,
        locale: 'en',
      ),
      Expanded(
        child:StreamBuilder<QuerySnapshot<TaskModel>>(
         stream: StreamTaskFromFireBase(selectedDate),
          builder:(context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
             return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Text('some thing went wrong');
            }
           List<TaskModel>tasks=snapshot.data?.docs.map((e) => e.data()).toList()??[];
return ListView.builder(
  itemCount: tasks.length,
    itemBuilder: (context,index){


  return TaskItem(tasks[index]);

}
);

          }
        )
      )
    ],


      )

    );
  }
}
