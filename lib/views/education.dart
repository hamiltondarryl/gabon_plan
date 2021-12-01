// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'dart:convert';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/services/requestS.dart';
import 'package:gabon_plan/views/search/resultaEducation.dart';
import 'package:gabon_plan/widgets/appbar.dart';
import 'package:gabon_plan/widgets/cardPharmaListMed.dart';
import 'package:gabon_plan/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Education extends StatefulWidget {
  final fill;

    const Education({this.fill});

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  TextEditingController controller =  TextEditingController();
  String filter = "";
  String fil = '';
  @override
  void initState() {
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
      onWillPop:()=>  Helpers.redirectTo(context) ,
      child: Scaffold(
          backgroundColor: Colors.black,
          endDrawer: const Drawer(
            child: CustomDrawer(),
          ),
          appBar: AppbarCustom(title: "Plan Education", color: ColorsSys.colorPog),
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
                                    builder: (context) => const FilterE()));
                          }),
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
                flex: 5,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FutureBuilder(
                        future: RequestHTTP.fetchAllLoisirForCity(1),
                        builder: (context, snapshot) {

                           var data ;
                              data = snapshot.data;

                          if (data == null) {
                            return Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(ColorsSys.colorPog)),
                            );
                          }
                         
                          return ListView.builder(
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
                                      color: ColorsSys.colorLoi
                              )
                                  : const SizedBox.shrink();
                            },
                          );
                        })),
              )
            ],
          )),
    );
  }
}

class FilterE extends StatefulWidget {
  const FilterE({Key? key}) : super(key: key);

  @override
  _FilterEState createState() => _FilterEState();
}

class _FilterEState extends State<FilterE> {
  List<Map> listCat = [];

  TextEditingController controller =  TextEditingController();
  String filter = "";

  void getCat() async {

    var url = Uri.parse(
        "https://serveur-sodepsi.com/gabonplan/utils/categories_education.php");

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
          backgroundColor: ColorsSys.colorPog,
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
                  fillColor: ColorsSys.colorPog,
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(25.7),
                    borderSide: BorderSide(color: ColorsSys.colorPog),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.7),
                    borderSide: BorderSide(color: ColorsSys.colorPog),
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
                                  builder: (context) => ResultatEducation(
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
        ]));
  }
}
