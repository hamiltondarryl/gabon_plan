// ignore_for_file: file_names, avoid_print, avoid_unnecessary_containers, avoid_function_literals_in_foreach_calls, unused_field

import 'package:flutter/material.dart';
import 'package:gabon_plan/services/requestS.dart';
import 'package:select_form_field/select_form_field.dart';

class GettingData extends StatefulWidget {
  const GettingData({Key? key}) : super(key: key);

  @override
  _GettingDataState createState() => _GettingDataState();
}

class _GettingDataState extends State<GettingData> {

  final List<Map<String, dynamic>> _villes = [];
  final List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    RequestHTTP.fetchVilles().then((tableau){
      setState(() {
        tableau.forEach((element) {
          _villes.add({
            'value': element.id,
            'label': element.libelle,
            'icon': const Icon(Icons.location_city),
          });
        });
      });
    });
  }

TextEditingController ville =  TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: ListView(
          children:  [
          SelectFormField(
              dialogCancelBtn : "Fermer",
              controller: ville,
              enableSearch: true,
              type: SelectFormFieldType.dialog, // or can be dialog
              icon: const Icon(Icons.format_shapes),
              labelText: 'Sélectionner une ville',
              items: _villes,
              onChanged: (val) => print(val),
              onSaved: (val) => print(val),
            )
          ],
        ),
      ),
    );
  }
}
