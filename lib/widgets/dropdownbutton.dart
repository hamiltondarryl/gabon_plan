// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// ignore: unused_element
class VillePageState extends StatelessWidget {
  static late final 
  // ignore: unused_field
  List<Map> listville = [];
  late String _ville;

  VillePageState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: buildDropdown(),
        ),
      );

  Widget buildDropdown() => Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _ville, // currently selected item
            items: listville.map((item) {
                              return  DropdownMenuItem(
                                child:  Text(_ville),
                                value: item.toString(),
                              );
                            }).toList(),
            onChanged: (value) => setState(() {
              _ville = value!;
            }),
          ),
        ),
      );
}

setState(Null Function() param0) {
}