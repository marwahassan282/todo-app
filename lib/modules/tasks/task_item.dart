import 'package:dotoapp/models/taskmodel.dart';
import 'package:dotoapp/provider/myprovider.dart';
import 'package:dotoapp/shared/components/components.dart';
import 'package:dotoapp/utils/add-task-firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../models/update-task-bottom-sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatefulWidget {
TaskModel taskmodel;
TaskItem(this.taskmodel);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late NavigatorState navigatorState;
  bool isclicable=false;
  @override
  void didChangeDependencies(){
    navigatorState=Navigator.of(context);
  }
  @override

  Widget build(BuildContext context) {
    var pro=Provider.of<MyProviderApp>(context);
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
      children: [
        SlidableAction(onPressed:(context){
          showmessage(context, AppLocalizations.of(context)!.sure, AppLocalizations.of(context)!.yes, () {
            deleteTask();
            navigatorState.pop();
          },Negativeactionname: AppLocalizations.of(context)!.no,Negativeactioncallback: (){
            navigatorState.pop();
          });

        },
          label: AppLocalizations.of(context)!.delete,
          icon: Icons.delete,
          backgroundColor: Colors.red,

        )
      ],
      ),
      child:InkWell (
        onTap: (){
          Navigator.pushNamed(context, UpdateTaskBottomSheet.routeName,arguments: TaskModel(id: '${widget.taskmodel.id}',title: '${widget.taskmodel.title}',description: '${widget.taskmodel.description}',dateTime: widget.taskmodel.dateTime,));
          ShowBottomSheet();
        },

          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: pro.themmode==ThemeMode.light?Colors.white:Colors.black, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
              Isclicable(isclicable),

                SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
    textclicable(isclicable),

                    Text(
                      '${widget.taskmodel.description}',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontSize: 12),
                    ),
                  ],
                )),
              Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: decoration(isclicable),
                    child: InkWell(
                      onTap: (){
                        isclicable=widget.taskmodel.isDone;
                        setState(() {



                        });

                      },
                      child: checkclicable(isclicable),
                      ),
                    ),


              ],
            ),
          ),

      ),
    );
  }

  void  deleteTask(){
    deleteTaskFrpmFireStore(widget.taskmodel);


  }
  Widget Isclicable(bool isclicable){
    if(isclicable){
     return Container(
        height: 50,

        color:Colors.green,
        width: 4,
      );}
    else{
  return  Container(
    height: 50,

    color:Theme.of(context).primaryColor,
    width: 4,
  );}



    }
 Widget textclicable(bool isclicable){
    if(isclicable){
      return  Text(
        '${widget.taskmodel.title}',
        style: Theme.of(context).textTheme.bodyText1,
      );
 }
    else{
      return    Text(
        '${widget.taskmodel.title}',
        style: Theme.of(context).textTheme.subtitle1,
      );
    }
    }
    Widget checkclicable(bool isclicable){
    if(isclicable){
      return Text('its done !',style: Theme.of(context).textTheme.bodyText2,); }
      else{//
        return  Icon(

          Icons.check,
          color: Colors.white,
          size: 25,

        );
    }
    }
    Decoration decoration(bool isclicable){
    if(isclicable){
      return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12));}
      else{
        return BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12));
    }
    }
  ShowBottomSheet(){
     UpdateTaskBottomSheet();


  }

    }






