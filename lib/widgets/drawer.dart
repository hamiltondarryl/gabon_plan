import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/config/imagesSys.dart';
import 'package:gabon_plan/views/contacter.dart';
import 'package:gabon_plan/views/politique.dart';
import 'package:gabon_plan/views/terme.condition.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsSys.black,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(ImageSys.logo),
            decoration: const BoxDecoration(
              border:
              Border(bottom: BorderSide(color: Colors.white, width: .6)),
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute( builder: (context) => Contacter() ));
                  },
                  leading: const Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: const Text(
                    "Contactez-nous",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Divider(color: Colors.white),
                const SizedBox(
                  height: 10.0,
                ),

                ListTile(
    onTap: () {
    Navigator.push(context, MaterialPageRoute( builder: (context) => Politique() ));
    },
                leading: const Icon(
                Icons.assignment_outlined,
                color: Colors.white,
                size: 30.0,
                ),
                title: const Text(
                  "Politique des confidenctialité",
                  style: TextStyle(color: Colors.white),
                )
                )
                ,
                const Divider(color: Colors.white),
                const SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute( builder: (context) => const TermeConditions() ));
                  },
                 leading : const Icon(
                    Icons.assignment_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ),
                 title : const Text(
                    "Termes et conditions ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Divider(color: Colors.white),
                const SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
