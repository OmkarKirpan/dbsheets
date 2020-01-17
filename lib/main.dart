import 'package:flutter/material.dart';
import 'package:dbsheets/myhome.dart';
// import 'package:dbsheets/fetchdata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple[900]),
      home: MyHome(),
    );
  }
}
