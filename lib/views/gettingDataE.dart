// ignore_for_file: file_names, avoid_print, avoid_unnecessary_containers, avoid_function_literals_in_foreach_calls, unused_field, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/services/requestS.dart';
import 'package:gabon_plan/views/search/resultMedicalByCityAndSpe.dart';
import 'package:select_form_field/select_form_field.dart';

class GettingEData extends StatefulWidget {
  const GettingEData({Key? key}) : super(key: key);

  @override
  _GettingEDataState createState() => _GettingEDataState();
}

class _GettingEDataState extends State<GettingEData> {
  final List<Map<String, dynamic>> _villes = [];
  final List<Map<String, dynamic>> _categories = [];
  bool loading = false;
  String villeSend = "";
  String specSend = "";

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

    RequestHTTP.fetchCategories(categorie: "education_cat").then((tableau) {
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
  }

  TextEditingController ville = TextEditingController();
  TextEditingController categorie = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: ColorsSys.colorPog,
        title: const Text("Choix ville et catégorie"),
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
                          BorderSide(color: ColorsSys.colorPog, width: 1.0),
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
                  labelText: 'Sélectionner une ville',
                  items: _villes,
                  onChanged: (val) {
                    print("la ville : $val");
                  },
                  onSaved: (val) {
                    print("$val");
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
                          BorderSide(color: ColorsSys.colorPog, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Choix de la spécialité",
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
                      return "Veuiller renseigner la spécialité";
                    }
                    return null;
                  },
                  enableSearch: true,
                  type: SelectFormFieldType.dialog, // or can be dialog
                  icon: const Icon(Icons.format_shapes),
                  labelText: 'Sélectionner une specialité',
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

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'la ville : ${ville.text} et la specialité : ${categorie.text}')),
                      );
                      RequestHTTP.fetchAllFilterMedicalForCity(
                              ville: ville.text, cat: categorie.text)
                          .then((resultat) {
                        setState(() {
                          loading = !loading;
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultMedicalByCityAndSpe(
                                    ville: villeSend,
                                    categorie: specSend,
                                    data: resultat)));
                      });
                    }
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Veuiller renseiller tous les champs')),
                      );
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorsSys.colorPog,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: loading
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.red,
                              )
                            : const Text(
                                "CONNEXION",
                                textScaleFactor: 1.1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                  )),
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
