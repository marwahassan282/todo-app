import 'package:dotoapp/models/taskmodel.dart';
import 'package:dotoapp/provider/myprovider.dart';
import 'package:dotoapp/shared/components/components.dart';
import 'package:dotoapp/utils/add-task-firebase.dart';
import
'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
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
    var pro=Provider.of<MyProviderApp>(context);
    return  Container(
        decoration: BoxDecoration(
          color: pro.themmode==ThemeMode.light?Colors.white:Theme.of(context).scaffoldBackgroundColor
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.addnewtask,style:provider.themmode==ThemeMode.light?Theme.of(context).textTheme.subtitle1:Theme.of(context).textTheme.subtitle1),
              Form(
               key: globalkey,
                child: Column(
                children: [
                  TextFormField(

                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.title,
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
              Text(AppLocalizations.of(context)!.time,style:provider.themmode==ThemeMode.light?Theme.of(context).textTheme.subtitle1:Theme.of(context).textTheme.subtitle1,textAlign:TextAlign.start,),
              SizedBox(height: 8,),
              InkWell(
                onTap: (){
                  openDatePicker();
                },
                  child: Text('${selectedTime.year} - ${selectedTime.month} - ${selectedTime.day}',style:provider.themmode==ThemeMode.light?Theme.of(context).textTheme.subtitle1:Theme.of(context).textTheme.subtitle1,textAlign:TextAlign.center)),
              SizedBox(height: 8,),
              ElevatedButton(onPressed: (){
                if(globalkey.currentState!.validate()){
                  TaskModel task=TaskModel(title: title, description: description, dateTime:DateUtils.dateOnly(selectedTime) .microsecondsSinceEpoch);

                  showloading(context, 'loading....');
                     addtaskfromfirebase(task).then((value) {

                       hideDialog(context);
                       showmessage(context, 'added successfully', 'ok', () {
                         Navigator.pop(context);
                       });

                     }).catchError((e){
                       
                     });
                }
               setState(() {

               });

              }, child: Text(AppLocalizations.of(context)!.addbutton,style: Theme.of(context).textTheme.subtitle1,))
            ],
          ),
        ),
      );

  }

openDatePicker()async{
    var chosenDate= await showDatePicker(context: context, initialDate: selectedTime, firstDate: DateTime.now(), lastDate:DateTime.now().add(Duration(days: 365)));
    if(chosenDate!=null){
      selectedTime=chosenDate;

    }
    setState(() {

    });
}
}
