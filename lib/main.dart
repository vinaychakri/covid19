import 'package:covid19/dashboards/User_Dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'covid_registration/LoginPage.dart';
import 'package:covid19/Auth.dart';
import 'Root_Page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID VACCINATION',
      theme: ThemeData(
        primarySwatch: Colors.green,
        //primaryColorBrightness: Brightness.light,
      ),
      home: RootPage(auth: new Auth()),
    );
  }
}

