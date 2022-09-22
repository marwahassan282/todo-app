import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotoapp/layout/home-layout.dart';
import 'package:dotoapp/models/update-task-bottom-sheet.dart';
import 'package:dotoapp/provider/myprovider.dart';
import 'package:dotoapp/shared/style/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await  Firebase.initializeApp(

  );
 // FirebaseFirestore.instance.disableNetwork();//data base become local on my phone not remote
  runApp( ChangeNotifierProvider(
      create: (BuildContext context) {
        return MyProviderApp();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget  {
late MyProviderApp provider;


  Widget build(BuildContext context) {
     provider=Provider.of<MyProviderApp>(context);
     initsharedpreference();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     localizationsDelegates: [

       AppLocalizations.delegate,
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
            ],

      supportedLocales: [
        Locale('en'), // English, no country code
        Locale('ar'), // Spanish, no country code
      ],
      locale: Locale(provider.language),
      initialRoute: homeLayout.routeName,
theme: MyThemeData.lightTheme,
darkTheme: MyThemeData.darkTheme,

themeMode:provider.themmode,
routes: {
        homeLayout.routeName:(c)=>homeLayout(),
  UpdateTaskBottomSheet.routeName:(c)=>UpdateTaskBottomSheet()

},
    );
  }
void initsharedpreference() async{
  final prefs = await SharedPreferences.getInstance();
  String lang=prefs.getString('language')??'en';
  provider.changeLanguage(lang);
  if(prefs.getString('theme')=='dark'){
    provider.changeTheme(ThemeMode.dark);
  }
  else{
    provider.changeTheme(ThemeMode.light);
  }
}
}





