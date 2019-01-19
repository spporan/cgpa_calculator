import 'package:cgpa_calculator/screens/home_screen.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(
    MaterialApp(
      title: 'This is a CGPA Calculated App',
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.teal[800],
        accentColor: Colors.teal[600],
      ),
    )
  );
}

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TabScreen();
  }
}