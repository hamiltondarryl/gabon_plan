// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/views/search/resultMedical.dart';

class ListSpeMe extends StatefulWidget {
  const ListSpeMe({Key? key}) : super(key: key);

  @override
  _ListSpeMeState createState() => _ListSpeMeState();
}

class _ListSpeMeState extends State<ListSpeMe> {
  @override
  Widget build(BuildContext context) {
    return const FilterM();
  }
}

class FilterM extends StatefulWidget {
  const FilterM({Key? key}) : super(key: key);

  @override
  _FilterMState createState() => _FilterMState();
}

class _FilterMState extends State<FilterM> {
  List<Map> listCat = [];

  TextEditingController controller =  TextEditingController();
  String filter = "";

  void getCat() async {

       var url = Uri.parse(
        "https://serveur-sodepsi.com/gabonplan/utils/specialite-medical.php");

    var request = await http.get(url);
    var response = jsonDecode(request.body);
    var datas = response["response"];
    for (var i = 0; i < datas.length; i++) {
      setState(() {
        listCat.add({"libelle": datas[i]["libelle"], "id": datas[i]["id"]});
      });
    }
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus!.unfocus();
    super.initState();
    getCat();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: ColorsSys.colorMed,
          title: const Text("Liste des spécialites"),
        ),
        body: Container(
          child: Column(children: [
            const SizedBox(height: 30.0),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                    color: Colors.black,
                    child: TextFormField(
                      controller: controller,
                      autofocus: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: "Rechercher...",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: ColorsSys.colorMed,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(25.7),
                          borderSide: BorderSide(color: ColorsSys.colorMed),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.7),
                          borderSide: BorderSide(color: ColorsSys.colorMed),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  itemCount: listCat.length,
                  itemBuilder: (ctx, index) {
                    return ("${listCat[index]["libelle"]} ")
                            .toLowerCase()
                            .contains(filter.toLowerCase())
                        ? GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultMedical(
                                          id: int.parse(listCat[index]["id"]),
                                          libelle: listCat[index]["libelle"],
                                        ))),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              height: 60,
                              width: double.infinity,
                              color: ColorsSys.sky,
                              child: ListTile(
                                title: Text(listCat[index]["libelle"]),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ]),
        ));
  }
}
