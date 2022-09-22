import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/myprovider.dart';

class bottomsheetTheme extends StatefulWidget {
  const bottomsheetTheme({Key? key}) : super(key: key);

  @override
  State<bottomsheetTheme> createState() => _bottomsheetThemeState();
}

class _bottomsheetThemeState extends State<bottomsheetTheme> {
  bool selected=false;
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
    return Column(
      children: [
        InkWell(
            onTap: (){
              provider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            child: changelanguagecolor('light', provider.themmode==ThemeMode.light?true:false)),
        
        SizedBox(height: 15,),
        InkWell(
            onTap: (){
              provider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: changelanguagecolor('dark', provider.themmode==ThemeMode.dark?true:false)),

      ]
    );
  }

  Widget changelanguagecolor(String text,bool selected){
    if(selected){
      return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$text',style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Theme.of(context).primaryColor
          ),
          ),
          Icon(Icons.check,color: Theme.of(context).primaryColor,)
        ],
      );

    }
    else
      return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$text',style: Theme.of(context).textTheme.subtitle1,),
          Icon(Icons.check,color: Colors.black,)
        ],
      );
  }
}
