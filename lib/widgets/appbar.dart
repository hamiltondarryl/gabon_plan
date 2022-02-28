// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {

  Color color ;
  String title;

   AppbarCustom({ Key? key, required this.title, required this.color}) : super(key: key);

     @override
     Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
    backgroundColor: Colors.black,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: color,),
      onPressed: () => Navigator.pop(context),
    ),
    iconTheme: IconThemeData(color: color),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    centerTitle: true,
  );
  }
}