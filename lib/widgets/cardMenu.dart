// ignore_for_file: file_names, avoid_unnecessary_containers


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gabon_plan/config/colorsSys.dart';

Widget cardMenu({context, title, image, color, page}) {
  return GestureDetector(
    onTap: () =>
        page == null ? null : Navigator.push(context, MaterialPageRoute(builder: (context) =>  page)),
    child: Card(
      elevation: 15.0,
      shadowColor: ColorsSys.green.withOpacity(.2),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                image,
                color: Colors.white,
                width: 50.0,
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 10.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17.0,
                    color:Colors.white,
                    fontFamily: "roboto",
                    fontWeight: FontWeight.w500
                  // fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
