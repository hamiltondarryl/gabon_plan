// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'dart:convert';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/services/requestS.dart';
import 'package:gabon_plan/widgets/appbar.dart';
import 'package:gabon_plan/widgets/cardPharmaListMed.dart';
import 'package:gabon_plan/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Loisir extends StatefulWidget {
  final fill;

  const Loisir({this.fill});

  @override
  _LoisirState createState() => _LoisirState();
}

class _LoisirState extends State<Loisir> {
  TextEditingController controller = TextEditingController();
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
      onWillPop: () => Helpers.redirectTo(context),
      child: Scaffold(
          backgroundColor: Colors.black,
          endDrawer: const Drawer(
            child: CustomDrawer(),
          ),
          appBar:
              AppbarCustom(title: "Plan Loisirs", color: ColorsSys.colorLoi),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 7.0, horizontal: 20.0),
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
                                    builder: (context) => const FilterL()));
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
                          var data;
                          data = snapshot.data;

                          if (data == null) {
                            return Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      ColorsSys.colorLoi)),
                            );
                          }
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (ctx, index) {
                              return ("${data[index].libelle}")
                                      .toLowerCase()
                                      .contains(filter.toLowerCase())
                                  ? CardPharmaMed(point: data[index],context: context, color: ColorsSys.colorLoi)
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

class FilterL extends StatefulWidget {
  const FilterL({Key? key}) : super(key: key);

  @override
  _FilterLState createState() => _FilterLState();
}

class _FilterLState extends State<FilterL> {
  List<Map> listCat = [];

  TextEditingController controller = TextEditingController();
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
          title: const Text("Filtre par catégorie"),
        ),
        body: Column(children: [
          const SizedBox(height: 30.0),
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
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          height: 60,
                          width: double.infinity,
                          color: ColorsSys.sky,
                          child: ListTile(
                            title: Text(listCat[index]["libelle"]),
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
