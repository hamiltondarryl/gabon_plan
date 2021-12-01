// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'dart:convert';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/services/requestS.dart';
import 'package:gabon_plan/views/search/resultMedical.dart';
import 'package:gabon_plan/widgets/appbar.dart';
import 'package:gabon_plan/widgets/cardPharmaListMed.dart';
import 'package:gabon_plan/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Medical extends StatefulWidget {
  final fill;

  const Medical({this.fill});

  @override
  _MedicalState createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  TextEditingController controller =  TextEditingController();
  String filter = "";
  String fil = '';
  @override
  void initState() {
    FocusManager.instance.primaryFocus!.unfocus();
    super.initState();
    filter = widget.fill == null ? "" : (widget.fill).toString();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> Helpers.redirectTo(context) ,
      child: Scaffold(
          backgroundColor: Colors.black,
          endDrawer: const Drawer(
            child: CustomDrawer(),
          ),
          appBar:  AppbarCustom(title: "Plan Médical", color: ColorsSys.colorMed),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                  color: Colors.black,
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.filter_list_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Filter()));
                          }),
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
              ),
              Expanded(
                flex: 5,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FutureBuilder(
                        future: RequestHTTP.fetchAllMedicalForCity(1),
                        builder: (context, snapshot) {

                          if (snapshot.connectionState == ConnectionState.done) {
                               var data ;
                               data = snapshot.data;

                            if (data == null) {
                              return const Center(child: Text('Pas de données disponibles', style: TextStyle(color: Colors.white),));
                            } else {
                              return  ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (ctx, index) {
                                  return ("${data[index].libelle}")
                                      .toLowerCase()
                                      .contains(filter.toLowerCase())
                                      ? CardPharmaMed(
                                      context: context,
                                      libelle: data[index].libelle,
                                      adresse: data[index].adresse,
                                      ville: data[index].ville,
                                      email: data[index].email,
                                      description: data[index].description,
                                      categorie: data[index].catId,
                                      lng: data[index].lng,
                                      lat: data[index].lat,
                                      contact: data[index].contact,
                                      horaires: data[index].horaires,
                                      jours: data[index].jours,
                                      image: data[index].image,
                                      color: ColorsSys.colorMed
                                  )
                                      : const SizedBox.shrink();
                                },
                              );
                            }
                          }  else {
                            return Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(ColorsSys.colorMed))); // loading
                          }
                        })),
              )
            ],
          )),
    );
  }
}

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<Map> listCat = [];

  TextEditingController controller =  TextEditingController();
  String filter = "";

  void getCat() async {
      var url = Uri.parse(
        "https://serveur-sodepsi.com/gabonplan/utils/categories_medical.php");
    var request = await http.get(url);
    var response = jsonDecode(request.body);
    var datas = response["response"];
    for (var i = 0; i < datas.length; i++) {
      setState(() {
        listCat.add({"libelle" : datas[i]["libelle"], "id" : datas[i]["id"]});
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
          title: const Text("Filtre par catégorie"),
        ),
        body: Column(children: [
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
          ),
          Expanded(
            flex: 5,
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
                                        libelle: listCat[index]["libelle"],
                                      id: int.parse(listCat[index]["id"]),
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
        ]));
  }
}
