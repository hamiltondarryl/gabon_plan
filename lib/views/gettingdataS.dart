// ignore_for_file: file_names, avoid_print, avoid_unnecessary_containers, avoid_function_literals_in_foreach_calls, unused_field, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/models/points.dart';
import 'package:gabon_plan/services/requestS.dart';
import 'package:gabon_plan/views/home.dart';
import 'package:gabon_plan/views/search/resultServiceByCityAndSpe.dart';
import 'package:gabon_plan/widgets/cardPharmaListMed.dart';
import 'package:select_form_field/select_form_field.dart';

class GettingDataS extends StatefulWidget {
  const GettingDataS({Key? key}) : super(key: key);

  @override
  _GettingDataSState createState() => _GettingDataSState();
}

class _GettingDataSState extends State<GettingDataS> {
  final List<Map<String, dynamic>> _villes = [];
  final List<Map<String, dynamic>> _categories = [];
  bool loading = false;
  String villeSend = "";
  String specSend = "";
  String filter = "";
  final List<Map<String, dynamic>> _points = [];
  late final List<PointlModel> data;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    RequestHTTP.fetchVilles().then((tableau) {
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

    RequestHTTP.fetchCategories(categorie: "service_cat").then((tableau) {
      setState(() {
        tableau.forEach((element) {
          _categories.add({
            'value': element.id,
            'label': element.libelle,
            'icon': const Icon(Icons.ac_unit),
          });
        });
      });
    });
    RequestHTTP.fetchLimit5Point(table: "Service-cat").then((tableau) {
      setState(() {
        tableau.forEach((element) {
          _points.add({
            'value': element.id,
            'label': element.libelle,
          });
        });
      });
    });
  }

  TextEditingController ville = TextEditingController();
  TextEditingController categorie = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home())),
        ),
        backgroundColor: ColorsSys.colorSer,
        title: const Text("Rechercher par ville et cat??gorie"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                child: SelectFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorsSys.colorSer, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Choix de la ville',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.white)),
                    // ignore: prefer_const_constructors
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // ignore: prefer_const_constructors
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.1,
                      ),
                    ),
                  ),
                  dialogCancelBtn: "Fermer",
                  controller: ville,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Veuiller renseigner la ville";
                    }
                    return null;
                  },
                  enableSearch: true,
                  type: SelectFormFieldType.dialog, // or can be dialog
                  icon: const Icon(Icons.format_shapes),
                  labelText: 'S??lectionner une ville',
                  items: _villes,
                  onChanged: (val) {
                    print("la ville : $val");
                  },
                  onSaved: (val) {
                    print("$val ////////");
                  },
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                child: SelectFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorsSys.colorSer, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Choix de la sp??cialit??",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.white)),
                    // ignore: prefer_const_constructors
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // ignore: prefer_const_constructors
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.1,
                      ),
                    ),
                  ),
                  dialogCancelBtn: "Fermer",
                  controller: categorie,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Veuiller renseigner la sp??cialit??";
                    }
                    return null;
                  },
                  enableSearch: true,
                  type: SelectFormFieldType.dialog, // or can be dialog
                  icon: const Icon(Icons.format_shapes),
                  labelText: 'S??lectionner une specialit??',
                  items: _categories,
                  onChanged: (val) {
                    print("la specialite : $val");
                  },
                  onSaved: (val) {
                    print("$val ////////");
                  },
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = !loading;
                      });
                      getVilleAndSpe();

                      RequestHTTP.fetchAllFilterServiceForCity(
                              ville: ville.text, cat: categorie.text)
                          .then((resultat) {
                        setState(() {
                          loading = !loading;
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultServiceByCityAndSpe(
                                    ville: villeSend,
                                    categorie: specSend,
                                    data: resultat)));
                      });
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorsSys.colorSer,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                "RECHERCHE",
                                textScaleFactor: 1.1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                  )),
                   Container(
                     margin: const EdgeInsets.only(top: 20),
                   height: MediaQuery.of(context).size.height/2.5,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FutureBuilder(
                        future: RequestHTTP.fetchLimit5Point(table: "service"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                              var data ;
                               data = snapshot.data;
                            if (snapshot.data == null ) {
                              return const Center(child: Text('Pas de r??sultats', style: TextStyle(color: Colors.white),));
                            }else if((snapshot.data.toString()) == "[]"){
                              return  const Center(child: Text('Pas de r??sultats', style: TextStyle(color: Colors.white),));
                            }
                             else {
                              return  ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (ctx, index) {
                                  return CardPharmaMed(
                                      point: data[index],
                                      context: context,
                                      color: ColorsSys.colorSer);

                                },
                              );
                            }
                          }  else {
                            return  Center(child: CircularProgressIndicator(backgroundColor: Colors.black, color: ColorsSys.colorSer,)); // loading
                          }
                        })
                ),
                )

            ],
          ),
        ),
      ),
    );
  }

  // recuperat..............
  void getVilleAndSpe() {
    _villes.forEach((element) {
      if (element["value"] == ville.text) {
        setState(() {
          villeSend = element["label"];
        });
      }
    });

    _categories.forEach((element) {
      if (element["value"] == categorie.text) {
        setState(() {
          specSend = element["label"];
        });
      }
    });
  }
}
