// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/views/home.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GABON PLAN',
      theme: ThemeData(
        primarySwatch: ColorsSys.pinkSy,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
