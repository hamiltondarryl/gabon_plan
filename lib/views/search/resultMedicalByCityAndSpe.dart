// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/models/points.dart';
import 'package:gabon_plan/views/listSpeMe.dart';
import 'package:gabon_plan/widgets/appbar.dart';
import 'package:gabon_plan/widgets/cardPharmaListMed.dart';
import 'package:gabon_plan/widgets/drawer.dart';

class ResultMedicalByCityAndSpe extends StatefulWidget {

  final String ville;
  final String categorie;
  final List<PointlModel> data;

  const ResultMedicalByCityAndSpe({required this.ville, required this.categorie, required this.data});


  @override
  _ResultMedicalByCityAndSpeState createState() => _ResultMedicalByCityAndSpeState();
}

class _ResultMedicalByCityAndSpeState extends State<ResultMedicalByCityAndSpe> {


  TextEditingController controller =  TextEditingController();
  String filter = "";
  @override
  void initState() {
    FocusManager.instance.primaryFocus!.unfocus();
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () => Helpers.redirectTo(context),
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
                child: Column(
                  children: [
                    Container(
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
                                        builder: (context) => const ListSpeMe()));
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
                    const SizedBox(height: 7.0,),
                    const Text("Résultats de la catégorie :", style: TextStyle(color: Colors.white),),
                    const SizedBox(height: 5.0,),
                    Expanded(child: Text(widget.categorie+ ' de ${widget.ville}', style: TextStyle(color: ColorsSys.colorMed, fontSize: 17.0),))
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView.builder(
                                itemCount: widget.data.length,
                                itemBuilder: (ctx, index) {
                                  return ("${widget.data[index].libelle}")
                                      .toLowerCase()
                                      .contains(filter.toLowerCase())
                                      ? CardPharmaMed(
                                      context: context,
                                      libelle: widget.data[index].libelle,
                                      adresse: widget.data[index].adresse,
                                      ville: widget.data[index].ville,
                                      email: widget.data[index].email,
                                      description: widget.data[index].description,
                                      categorie: widget.data[index].catId,
                                      lng: widget.data[index].lng,
                                      lat: widget.data[index].lat,
                                      contact: widget.data[index].contact,
                                      horaires: widget.data[index].horaires,
                                      jours: widget.data[index].jours,
                                      image: widget.data[index].image,
                                      color: ColorsSys.colorMed
                                  )
                                      : const SizedBox.shrink();
                                },
                              )
                ),
              )
            ],
          )),
    );
  }
}




