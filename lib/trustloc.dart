import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:trust_location/trust_location.dart';
import 'package:location_permissions/location_permissions.dart';

class trusloc extends StatefulWidget {
  @override
  _truslocState createState() => _truslocState();
}

class _truslocState extends State<trusloc> {
  String? _latitude;
  String? _longitude;
  bool? _isMockLocation;

  /// initialize state.
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    TrustLocation.start(5);
    getLocation();
  }

  /// get location method, use a try/catch PlatformException.
  Future<void> getLocation() async {
    try {
      TrustLocation.onChange.listen((values) => setState(() {
            _latitude = values.latitude;
            _longitude = values.longitude;
            _isMockLocation = values.isMockLocation;
          }));
    } on PlatformException catch (e) {
      print('PlatformException $e');
    }
  }

  /// request location permission at runtime.
  void requestLocationPermission() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    print('permissions: $permission');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LOKASI MOCK CUI BY YUDA'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            requestLocationPermission();
            TrustLocation.start(5);
            getLocation();
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.navigation),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Column(
            children: <Widget>[
              Text('Terdektesi Mock: $_isMockLocation'),
              Text('Latitude: $_latitude, Longitude: $_longitude'),
            ],
          )),
        ),
      ),
    );
  }
}
