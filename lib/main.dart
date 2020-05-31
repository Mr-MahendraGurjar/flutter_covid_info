import 'package:flutter/material.dart';
import 'package:fluttercovidinfo/homepage.dart';
import 'package:fluttercovidinfo/datasorce.dart';

void main(){
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Covid Info",
      theme: ThemeData(
        fontFamily: 'Circular',
        primaryColor: primaryBlack
      ),
      home: Homepage(),
    );
  }
}
