

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:dotoapp/models/taskmodel.dart';
import 'package:dotoapp/provider/myprovider.dart';
import 'package:dotoapp/shared/components/components.dart';
import 'package:dotoapp/utils/add-task-firebase.dart';
import
'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateTaskBottomSheet extends StatefulWidget {
  static String routeName='update';

  @override
  State<UpdateTaskBottomSheet> createState() => _UpdateTaskBottomSheetState();
}

class _UpdateTaskBottomSheetState extends State<UpdateTaskBottomSheet> {

  late NavigatorState navigatorState;
  @override
  void didChangeDependencies(){
    navigatorState=Navigator.of(context);
  }
  var selectedTime=DateTime.now();
  var globalkey=GlobalKey<FormState>();
  String title='';
  String description='';
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
var model=ModalRoute.of(context)?.settings.arguments as TaskModel;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.update,style:provider.themmode==ThemeMode.light?Theme.of(context).textTheme.subtitle1:Theme.of(context).textTheme.subtitle1),
                  Form(
                    key: globalkey,
                    child: Column(
                      children: [
                        TextFormField(

                          decoration: InputDecoration(
                            labelText:AppLocalizations.of(context)!.title,
labelStyle: TextStyle(
  color: provider.themmode==ThemeMode.light?Colors.black:Colors.white
)

                          ),
                          onChanged: (text){
                            title=text;
                          },
                          validator: (text){
                            if(text==null||text.isEmpty) {
                              return 'please enter title';
                            }
                            return null;
                          },

                        ),
                        TextFormField(
                          minLines: 4,
                          maxLines: 4,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.description,
                              labelStyle: TextStyle(
                                  color: provider.themmode==ThemeMode.light?Colors.black:Colors.white
                              )
                          ),
                          onChanged: (text){
                            description=text;
                          },
                          validator: (text){
                            if(text==null||text.isEmpty) {
                              return 'please enter description';
                            }
                            return  null;
                          },

                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 12,),


                  SizedBox(height: 8,),
                  ElevatedButton(onPressed: (){
                    if(globalkey.currentState!.validate()){
                      TaskModel task=TaskModel(id:model.id,title: title, description: description, dateTime:model.dateTime,isDone: true);

                      showloading(context, 'loading....');
                    UpdateTaskFrpmFireStore(task).then((value) {

                        hideDialog(context);
                        showmessage(context, 'updated successfully', 'ok', () {
                          Navigator.pop(context);
                        });

                      }).catchError((e){

                      });
                    }
                    setState(() {

                    });

                  }, child: Text(AppLocalizations.of(context)!.updatebutton,style: Theme.of(context).textTheme.subtitle1,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 openDatePicker()async{
    CalendarTimeline(
      initialDate:selectedTime ,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateSelected: (date) {
        selectedTime=date;
        setState(() {

        });
      },
      leftMargin: 20,
      monthColor: Colors.black,
      dayColor: Colors.black,
      activeDayColor: Theme.of(context).primaryColor,
      activeBackgroundDayColor: Colors.white,
      dotsColor: Theme.of(context).primaryColor,
      selectableDayPredicate: (date) => true,
      locale: 'en',
    );


    }



  }



