
import 'package:gabon_plan/views/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';


class Helpers {


  static String smallSentence(String bigSentence, int lenght, int limit) {
    if (bigSentence.length > lenght) {
      return bigSentence.substring(0, limit) + '...';
    } else {
      return bigSentence;
    }
  }

  // pour les appels
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }


  // pour les mails
  static  Future<void> makeEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launch(launchUri.toString());
  }

  static Future<bool> redirectTo(context) async {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
    return true;
}


}