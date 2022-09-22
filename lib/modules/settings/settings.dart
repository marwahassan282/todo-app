import 'package:dotoapp/modules/settings/boottomsheettheme.dart';
import 'package:dotoapp/provider/myprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bottomsheetlanguage.dart';

class settingTabs extends StatefulWidget {


  @override
  State<settingTabs> createState() => _settingTabsState();
}

class _settingTabsState extends State<settingTabs> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
    return Container(
     child: Padding(
       padding: const EdgeInsets.all(12.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           Text(AppLocalizations.of(context)!.language,style: Theme.of(context).textTheme.subtitle1,),
           SizedBox(height: 12),
           InkWell(
             onTap: (){
            showbottomsheetlanguage();
             },
             child: Container(
               padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
               decoration: BoxDecoration(
                 color:  provider.themmode==ThemeMode.light?Colors.white:Colors.black,
                 borderRadius: BorderRadius.circular(12)
               ),
               child: Text(provider.language=='en'?AppLocalizations.of(context)!.english:AppLocalizations.of(context)!.arabic,style:Theme.of(context).textTheme.subtitle1),
             ),
           ),
           SizedBox(height: 15,),
           Text(AppLocalizations.of(context)!.theme,style: Theme.of(context).textTheme.subtitle1,),
           SizedBox(height: 12),
           InkWell(
             onTap: (){
               showbottomsheetTheme();
             },
             child: Container(
               padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
               decoration: BoxDecoration(
                   color: provider.themmode==ThemeMode.light?Colors.white:Colors.black,
                   borderRadius: BorderRadius.circular(12)
               ),
               child: Text(provider.themmode==ThemeMode.light?AppLocalizations.of(context)!.light:AppLocalizations.of(context)!.dark,style: Theme.of(context).textTheme.subtitle1),
             ),
           ),

         ],
       ),
     ),
    );
  }

  showbottomsheetlanguage(){
    showModalBottomSheet(context: context, builder:(context){
      return bottomSheetLanguage ();
    });
  }
  showbottomsheetTheme(){
    showModalBottomSheet(context: context, builder:(context){
      return bottomsheetTheme ();
    });
  }
}
