import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/config/imagesSys.dart';
import 'package:gabon_plan/views/gettibDataL.dart';
import 'package:gabon_plan/views/gettingData.dart';
import 'package:gabon_plan/views/gettingDataE.dart';
import 'package:gabon_plan/views/gettingDataS.dart';
import 'package:gabon_plan/widgets/cardMenu.dart';
import 'package:gabon_plan/widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 15.0),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(ImageSys.bg),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.35), BlendMode.dstATop)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageSys.logo,
                          width: 60,
                        ),
                        IconButton(
                          icon: const Icon(Icons.menu),
                          color: ColorsSys.pinkSy,
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
                    const SizedBox(height: 20.0),
                    const Text(
                      "Bienvenue sur GabonPlan",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 25.0),
                    ),
                    const SizedBox(height: 22.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Vous pouvez rechercher des lieux où vous changez les idées, trouver une structure sanitaire, et des services métiers.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      ),
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
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(50),
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          crossAxisCount: 2,
                          children: <Widget>[
                            cardMenu(
                                context: context,
                                title: "Plan Services",
                                color: ColorsSys.colorSer,
                                image: ImageSys.service,
                                page: const GettingDataS()),
                            cardMenu(
                                context: context,
                                title: "Plan Médical",
                                color: ColorsSys.colorMed,
                                image: ImageSys.host,
                                page: const GettingData()),
                            cardMenu(
                                context: context,
                                title: "Plan Loisirs",
                                color: ColorsSys.colorLoi,
                                image: ImageSys.cockteil,
                                page: const GettingLData()),
                            cardMenu(
                                context: context,
                                title: "Plan Education",
                                color: ColorsSys.colorPog,
                                image: ImageSys.school,
                                page: const GettingEData()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
