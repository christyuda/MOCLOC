import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.873183, 107.575944),
    zoom: 14,
  );

// final List<Marker> _markers = const<Marker>[Marker(
//       markerId: MarkerId('1'),
//       position: LatLng(-6.873183, 107.575944),
//       infoWindow: InfoWindow(title: 'Posisiku'),
//     ),]

  //menambah marker
  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(-6.873183, 107.575944),
      infoWindow: InfoWindow(title: 'Posisiku'),
    ),
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(-6.872497, 107.576603),
      infoWindow: InfoWindow(title: 'Posisiku2'),
    )
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: GoogleMap(
  //       initialCameraPosition: _kGooglePlex,
  //       markers: Set<Marker>.of(_marker),
  //       onMapCreated: (GoogleMapController controller) {
  //         _controller.complete(controller);
  //       },
  //     ),
  //   );
  // }
  //animasinya guise
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(-6.872497, 107.576603), zoom: 30),
          ));
          setState(() {});
        },
      ),
    );
  }
}
