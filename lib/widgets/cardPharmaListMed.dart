// ignore_for_file: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gabon_plan/config/colorsSys.dart';
import 'package:gabon_plan/helpers/functions.dart';
import 'package:gabon_plan/views/detailsList/detailPoint.dart';

// ignore: non_constant_identifier_names
Widget CardPharmaMed({
  context,
  libelle,
  ville,
  categorie,
  adresse,
  horaires,
  email,
  contact,
  jours,
  description,
  lng,
  lat,
  image,
  color,
})

{
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Detail(
                libelle: libelle,
                adresse: adresse,
                ville : ville,
                horaires: horaires,
                jours: jours,
                email: email,
                categorie: categorie,
                description: description,
                lng: lng,
                lat: lat,
                contact: contact,
                image: image,
                color: color,
                site: '',
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
              width : 150.0,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
              ),
              child: CachedNetworkImage(
              imageUrl:  "https://serveur-sodepsi.com/gabonplan/images/uploads/$image",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: imageProvider ,
                      fit: BoxFit.cover,
                      colorFilter:ColorFilter.mode(
                          Colors.black.withOpacity(0.8), BlendMode.dstATop)),
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                            )),
                        child: Text(categorie,
                            style: const TextStyle(
                              color: Colors.white,
                            )),
                      )
                    ],
                  )
              ),
              placeholder: (context, url) => Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(color))),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
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
                        Helpers.smallSentence(libelle, 35, 30),
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
                                Helpers.smallSentence(adresse, 20, 15),
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
                            Expanded(
                              child: Text(
                                horaires,
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
