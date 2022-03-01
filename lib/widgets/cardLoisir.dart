// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/models/points.dart';
import 'package:gabon_plan/views/detailsList/detailPoint.dart';

// ignore: non_constant_identifier_names
Widget CardPharmaLoisir({required PointlModel point ,required BuildContext context,required Color color})

{
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Detail( point: point, color: color,
              )));
    },
    child: Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Row(
            children: [
              Container(
                width: 150.0,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(10)),
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(point.image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: ColorsSys.pink,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                          )),
                      child: Text(point.catId,
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       Helpers.smallSentence(point.libelle, 35, 30),
                        style: TextStyle(
                          fontSize: 17.0,
                          color: ColorsSys.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Adresse :",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: ColorsSys.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                Helpers.smallSentence(point.adresse, 20, 15),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: ColorsSys.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Ouvert :",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: ColorsSys.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              point.horaires,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: ColorsSys.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.white,
        )
      ],
    ),
  );
}
