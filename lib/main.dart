import 'package:flutter/material.dart';
import 'package:tmp_finalproject/login_page.dart';
import 'package:tmp_finalproject/main_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}