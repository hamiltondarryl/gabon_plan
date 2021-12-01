// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gabon_plan/helpers/functions.dart';

class Contacter extends StatefulWidget {
  @override
  _ContacterState createState() => _ContacterState();
}

class _ContacterState extends State<Contacter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Contactez-nous"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            const SizedBox(height: 20),
            const Text("La maison d'édition le privé reste disponible sur les coordonées suivantes .", style: TextStyle(color: Colors.white, fontSize: 16 )),
            const SizedBox(height: 20),
            ListTile(
              onTap: ()=> Helpers.makePhoneCall("+24111766150"),
              leading: const Icon(
                Icons.call,
                color: Colors.white,
                size: 30.0,
              ),
              title: const Text("Contact : +24111766150", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            ListTile(
              onTap: ()=> Helpers.makeEmail("lepol@lepriveonline.com"),
              leading: const Icon(
                Icons.email,
                color: Colors.white,
                size: 30.0,
              ),
              title: const Text("Email : lepol@lepriveonline.com", style: TextStyle(color: Colors.white, fontSize: 16)),
            )
        ]
      )
    );
  }

}
