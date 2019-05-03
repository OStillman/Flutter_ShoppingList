import 'package:flutter/material.dart';
import 'helpers/constants.dart';
import 'MainScreen.dart';
import 'AddScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //Allows the use of tags to reference each individual page
  final routes = <String, WidgetBuilder>{
    homePageTag: (context) => MainScreen(),
    addPageTag: (context) => AddScreen(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primaryColor: mainAppColor,
      ),
      home: MainScreen(),
      routes: routes,
    );
  }
}
