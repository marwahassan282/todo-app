import 'package:dotoapp/models/add-task-bottom-sheet.dart';

import 'package:dotoapp/modules/tasks/task.dart';
import 'package:dotoapp/provider/myprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../modules/settings/settings.dart';
class homeLayout extends StatefulWidget {
static String routeName='home';

  @override
  State<homeLayout> createState() => _homeLayoutState();
}

class _homeLayoutState extends State<homeLayout> {
int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
    return Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.todoTitle,style:provider.themmode==ThemeMode.light?Theme.of(context).textTheme.headline1:Theme.of(context).textTheme.headline2),
    ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: provider.themmode==ThemeMode.light?Colors.white:Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        shape: CircularNotchedRectangle(
        ),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (index){
            currentIndex=index;
            setState(() {

            });
          },
          currentIndex: currentIndex,

          items: [
            BottomNavigationBarItem(icon:Icon (Icons.list),label:AppLocalizations.of(context)!.tasks ),
            BottomNavigationBarItem(icon:Icon (Icons.settings),label: AppLocalizations.of(context)!.setting),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 4,
        )
        ),
        onPressed: () {
          ShowBottomSheet();
        },
        child: Icon(Icons.add),
      ),

    );
  }
  List<Widget> tabs=[TaskTab(),settingTabs()];
ShowBottomSheet(){
  showModalBottomSheet(context: context, builder: (context){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AddTaskBottomSheet(),
    );
  });
}
}
