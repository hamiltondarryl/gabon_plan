// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, unnecessary_null_comparison
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/views/map/map.dart';
import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/widgets/drawer.dart';

class Detail extends StatefulWidget {
  final String libelle;
  final String ville;
  final String categorie;
  final String adresse;
  final String horaires;
  final String email;
  final String site;
  final String description;
  final String jours;
  final String contact;
  final double lng;
  final double lat;
  final String image;
  final Color color;

   const Detail({
    required this.libelle,
    required this.ville,
    required this.categorie,
    required this.adresse,
    required this.horaires,
    required this.email,
    required this.site,
    required this.description,
    required this.jours,
    required this.contact,
    required this.lng,
    required this.lat,
    required this.image,
    required this.color
  });

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var longitude;
  var latitude;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      endDrawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: NetworkImage("https://serveur-sodepsi.com/gabonplan/images/uploads/${widget.image}"),
                    fit: BoxFit.cover,
                    colorFilter:  ColorFilter.mode(
                        Colors.black.withOpacity(0.35), BlendMode.dstATop)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: widget.color,
                          ),
                          onPressed: () => Navigator.pop(context)),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        color: widget.color,
                        iconSize: 35.0,
                        onPressed: () {
                          if (_drawerKey.currentState!.isEndDrawerOpen) {
                            _drawerKey.currentState!.openDrawer();
                          } else {
                            _drawerKey.currentState!.openEndDrawer();
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    widget.libelle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25.0),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  )
                ],
              ),
            ),
            Expanded(
                child: Transform.translate(
              offset: const Offset(0, -45),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "INFORMATIONS",
                          style: TextStyle(
                              color: ColorsSys.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Adresse : ",
                              style: TextStyle(
                                  color: widget.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            Expanded(
                                child: Text(widget.adresse,
                                    style: TextStyle(
                                        color: ColorsSys.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0))),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Categorie  : ",
                              style: TextStyle(
                                  color: widget.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            Expanded(
                                child: Text(widget.categorie,
                                    style: TextStyle(
                                        color: ColorsSys.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0))),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact  : ",
                              style: TextStyle(
                                  color:widget.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            widget.contact  == "" ?  Expanded(child: Text("Indisponible pour le moment", style:  TextStyle(
                                color: ColorsSys.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0))) : Expanded(
                                child: InkWell(
                                  onTap: ()=> Helpers.makePhoneCall(widget.contact),
                                  child: Text(widget.contact,
                                      style: TextStyle(
                                          color: ColorsSys.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0)),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email  : ",
                              style: TextStyle(
                                  color: widget.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            widget.email  == "" ?  Expanded(child: Text("Indisponible pour le moment", style:  TextStyle(
                                color: ColorsSys.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0))) : Expanded(
                                child: InkWell(
                                  onTap:()=> Helpers.makeEmail(widget.email),
                                  child: Text(widget.email,
                                      style: TextStyle(
                                          color: ColorsSys.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0)),
                                )
                            ),
                          ],
                        ),
                         const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Site  : ",
                              style: TextStyle(
                                  color: widget.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            widget.site  == "" ?  Expanded(child: Text("Indisponible pour le moment", style:  TextStyle(
                                color: ColorsSys.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0))) : Expanded(
                                child: Text(  widget.site,
                                    style: TextStyle(
                                        color: ColorsSys.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0))),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Horaires  : ",
                              style: TextStyle(
                                  color: widget.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            Expanded(
                                child: Text(widget.horaires,
                                    style: TextStyle(
                                        color: ColorsSys.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0))),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jours ouvrables  : ",
                              style: TextStyle(
                                  color: widget.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            Expanded(
                                child: Text(widget.jours,
                                    style: TextStyle(
                                        color: ColorsSys.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0))),
                          ],
                        ),
                         const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Autre  : ",
                              style: TextStyle(
                                  color: widget.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            Expanded(
                                child: Text("",
                                    style: TextStyle(
                                        color: ColorsSys.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: widget.color,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Map(
                        lng: widget.lng,
                        lat: widget.lat,
                        libelle: widget.libelle,
                        color: widget.color,
                      )
              )
          );
        },
        label: const Text(" Voir sur la carte"),
        icon: const Icon(
          Icons.map,
          color: Colors.white,
        ),
      ),
    );
  }
}
