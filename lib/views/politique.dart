
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Politique extends StatefulWidget {
  @override
  _PolitiqueState createState() => _PolitiqueState();
}

class _PolitiqueState extends State<Politique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Politique des confidenctialité"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: const [
          Text("La Maison d'édition le privé built the Gabon plan app. This SERVICE is provided by SODEPSI AD at no cost and is intended for use as is.  This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.", style: TextStyle(color: Colors.white, fontSize: 16),),
          SizedBox(height: 10),
          Text("If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that We collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Gabon plan unless otherwise defined in this Privacy Policy",  textAlign: TextAlign.justify ,style: TextStyle(color: Colors.white, fontSize: 16),),
          SizedBox(height: 10),
          Text("Information Collection and Use",  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold )),
          SizedBox(height: 10),
          Text("For a better experience, while using our Service, We may require you to provide us with certain personally identifiable information, including but not limited to Selemani Gad. The information that We request will be retained by us and used as described in this privacy policy. The app does use third-party services that may collect information used to identify you. Link to the privacy policy of third-party service providers used by the app",  textAlign: TextAlign.justify , style: TextStyle(color: Colors.white, fontSize: 16))
        ],
      )
    );
  }
}
