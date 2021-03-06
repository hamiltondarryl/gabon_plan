// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/models/points.dart';
import 'package:gabon_plan/views/gettingDataE.dart';
import 'package:gabon_plan/widgets/appbar.dart';
import 'package:gabon_plan/widgets/cardPharmaListMed.dart';
import 'package:gabon_plan/widgets/drawer.dart';

class ResultEducationByCityAndSpe extends StatefulWidget {
  final String ville;
  final String categorie;
  final List<PointlModel> data;

  const ResultEducationByCityAndSpe(
      {required this.ville, required this.categorie, required this.data});

  @override
  _ResultEducationByCityAndSpeState createState() =>
      _ResultEducationByCityAndSpeState();
}

class _ResultEducationByCityAndSpeState
    extends State<ResultEducationByCityAndSpe> {
  TextEditingController controller = TextEditingController();
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
      onWillPop: () => Helpers.redirectTo(context),
      child: Scaffold(
          backgroundColor: Colors.black,
          endDrawer: const Drawer(
            child: CustomDrawer(),
          ),
          appBar:
              AppbarCustom(title: "Plan Education", color: ColorsSys.colorPog),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
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
                                        builder: (context) =>
                                            const GettingEData()));
                              }),
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
                    const SizedBox(
                      height: 7.0,
                    ),
                    const Text(
                      "R??sultats de la cat??gorie :",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                        child: Text(
                      widget.categorie + ' de ${widget.ville}',
                      style:
                          TextStyle(color: ColorsSys.colorPog, fontSize: 17.0),
                    ))
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: widget.data.isNotEmpty ? ListView.builder(
                      itemCount: widget.data.length,
                      itemBuilder: (ctx, index) {
                        return ("${widget.data[index].libelle}")
                                .toLowerCase()
                                .contains(filter.toLowerCase())
                            ? CardPharmaMed(point: widget.data[index], context: context, color: ColorsSys.colorPog)
                            : const SizedBox.shrink();
                      },
                      ): const Center(
                        child: Text("Pas de r??sultat", style: TextStyle(color: Colors.white, fontSize: 20)),
                      )
                    ),
              )
            ],
          )),
    );
  }
}
