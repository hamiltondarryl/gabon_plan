// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_field

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  final double lng;
  final double lat;
  final String libelle;
  final Color color;

  const  Map(
      {required this.lng,
      required this.lat,
      required this.libelle,
      required this.color});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final Set<Marker> _markers = HashSet<Marker>();

  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("0"),
          position: LatLng(widget.lat, widget.lng),
          infoWindow: InfoWindow(
            title: widget.libelle,
          )));
    });
  }

  // ignore: deprecated_member_use
  List<LatLng> polylineLatLong = <LatLng>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: const Text("Position géographique"),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.lng),
                zoom: 14,
              ),
              markers: _markers,
            )
          ],
        ));
  }
}
