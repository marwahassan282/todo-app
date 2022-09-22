import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/myprovider.dart';

class bottomSheetLanguage extends StatefulWidget {
  @override
  State<bottomSheetLanguage> createState() => _bottomSheetLanguageState();
}

class _bottomSheetLanguageState extends State<bottomSheetLanguage> {
bool selected=false;



  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProviderApp>(context);
    return Column(
      children: [
      InkWell(
    onTap: (){
      provider.changeLanguage('en');
      Navigator.pop(context);
    },
    child: changelanguagecolor('English', provider.language=='en'?true:false)),
        SizedBox(height: 15,),
        InkWell(
            onTap: (){
              provider.changeLanguage('ar');
              Navigator.pop(context);
            },
            child: changelanguagecolor('العربية', provider.language=='ar'?true:false)),
      ],
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
