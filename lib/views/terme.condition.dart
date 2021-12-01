import 'package:flutter/material.dart';

class TermeConditions extends StatefulWidget {
  const TermeConditions({Key? key}) : super(key: key);

  @override
  _TermeConditionsState createState() => _TermeConditionsState();
}

class _TermeConditionsState extends State<TermeConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Termes et conditions"),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: const [
            Text("By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Selemani Gad.", textAlign: TextAlign.justify,  style: TextStyle(color: Colors.white, fontSize: 16)),
             SizedBox(height: 10),
             Text("Selemani Gad is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.", textAlign: TextAlign.justify , style: TextStyle(color: Colors.white, fontSize: 16)),
          ]
      ),
    );
  }
}
