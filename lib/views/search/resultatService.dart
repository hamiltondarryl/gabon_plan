// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/services/requestS.dart';
import 'package:gabon_plan/views/service.dart';
import 'package:gabon_plan/widgets/appbar.dart';
import 'package:gabon_plan/widgets/cardPharmaListMed.dart';
import 'package:gabon_plan/widgets/drawer.dart';

class ResultatService extends StatefulWidget {


  final int id;
  final String libelle;

  const ResultatService({required this.id, required this.libelle});

  @override
  _ResultatServiceState createState() => _ResultatServiceState();
}

class _ResultatServiceState extends State<ResultatService> {


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
      onWillPop: () => Helpers.redirectTo(context) ,
      child: Scaffold(
          backgroundColor: Colors.black,
          endDrawer: const Drawer(
            child: CustomDrawer(),
          ),
          appBar: AppbarCustom(title: "Plan Service", color: ColorsSys.colorSer),
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
                                        builder: (context) => const FilterS()));
                              }),
                          hintText: "Rechercher...",
                          hintStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: ColorsSys.colorSer,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(25.7),
                            borderSide: BorderSide(color: ColorsSys.colorSer),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.7),
                            borderSide: BorderSide(color: ColorsSys.colorSer),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7.0,),
                    const Text("Résultats de la catégorie :", style: TextStyle(color: Colors.white),),
                    Expanded(child: Text(widget.libelle, style: TextStyle(color: ColorsSys.colorSer, fontSize: 17.0),))
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FutureBuilder(
                        future: RequestHTTP.fetchAllFilterServiceForCity(1, widget.id),
                        builder: (context, snapshot) {

                          if (snapshot.connectionState == ConnectionState.done) {
                            
                             var data;
                               data = snapshot.data;

                            if (data == null) {
                              return const Center(child: Text('Pas de résultats', style: TextStyle(color: Colors.white),));
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
                                      color: ColorsSys.colorSer
                                  )
                                      : const SizedBox.shrink();
                                },
                              );
                            }
                          }  else {
                            return const Center(child: CircularProgressIndicator()); // loading
                          }
                        })
                ),
              )
            ],
          )),
    );
  }
}
