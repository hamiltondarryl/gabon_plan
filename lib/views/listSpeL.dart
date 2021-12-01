// ignore_for_file: file_names, avoid_unnecessary_containers
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/views/search/resultatLoisir.dart';

class ListSpe extends StatefulWidget {
  const ListSpe({Key? key}) : super(key: key);

  @override
  _ListSpeState createState() => _ListSpeState();
}

class _ListSpeState extends State<ListSpe> {
  @override
  Widget build(BuildContext context) {
    return const FilterL();
  }
}

class FilterL extends StatefulWidget {
  const FilterL({Key? key}) : super(key: key);

  @override
  _FilterLState createState() => _FilterLState();
}

class _FilterLState extends State<FilterL> {
  List<Map> listCat = [];

  TextEditingController controller =  TextEditingController();
  String filter = "";

  void getCat() async {
         var url = Uri.parse(
        "https://serveur-sodepsi.com/gabonplan/utils/categories_loisir.php");
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
          backgroundColor: ColorsSys.colorLoi,
          title: const Text("Presention des catégories"),
        ),
        body: Container(
          child: Column(children: [
            const SizedBox(height: 30.0),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
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
                    fillColor: ColorsSys.colorLoi,
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.7),
                      borderSide: BorderSide(color: ColorsSys.colorLoi),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.7),
                      borderSide: BorderSide(color: ColorsSys.colorLoi),
                    ),
                  ),
                ),
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
                                    builder: (context) => ResultatLoisir(
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
