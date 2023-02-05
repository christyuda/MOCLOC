import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trust_location/trust_location.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:flutter/services.dart';
import 'package:flutterloc/model/ModelStartKelas.dart';
import 'dart:developer';

class GetUserCurrentLocationScreen extends StatefulWidget {
  GetUserCurrentLocationScreen(
      {super.key, required this.jadwalId, required this.token});

  String token;
  String jadwalId;
  @override
  _GetUserCurrentLocationScreenState createState() =>
      _GetUserCurrentLocationScreenState(token, jadwalId);
}

class _GetUserCurrentLocationScreenState
    extends State<GetUserCurrentLocationScreen> {
  String? _latitude;
  String? _longitude;
  bool? _isMockLocation;
  final String token;
  final String jadwalId;
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.873183, 107.575944),
    zoom: 20,
  );

  final List<Marker> _marker = <Marker>[
    // Marker(
    //     markerId: MarkerId('1'),
    //     position: LatLng(-6.884938, 107.615420),
    //     infoWindow: InfoWindow(title: 'titik marker'))
  ];

  _GetUserCurrentLocationScreenState(this.token, this.jadwalId);

  loadData() {
    getUserCurrentLocation().then((value) async {
      _marker.add(Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'lokasiku')));

      CameraPosition cameraPosition = CameraPosition(
          zoom: 14, target: LatLng(value.latitude, value.longitude));
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("erorr gais$error");
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    getLocation().then((value) => null);
    requestLocationPermission();
    TrustLocation.start(5);
  }

  Future<void> getLocation() async {
    try {
      TrustLocation.onChange.listen((values) => setState(() {
            _latitude = values.latitude!;
            _longitude = values.longitude!;
            _isMockLocation = values.isMockLocation;
          }));
    } on PlatformException catch (e) {
      print('PlatformException $e');
    }
  }

  Future<void> startKelas(String jadwalid, int lat, int long) async {
    var dataPost = DataKelasMulai(
        jadwalId: jadwalId,
        materiPerkuliahan: "pantek",
        position: PositionLoc(latitude: lat, longitude: long));
    // print(dataPost.toJson());
    var resp_dio = await Dio().post(
        'https://iteungdroid-dev.ulbi.ac.id/api/v1/akademik/kelas/tatapmuka',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: dataPost.toMap());

    var dataKelas = MulaiKelas.fromMap(resp_dio.data);
    SnackBar(content: Text(dataKelas.status));
    SnackBar(content: Text(dataKelas.code.toString()));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("lokasi"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            loadData();
            getLocation().then((value) => null);
            requestLocationPermission();
            TrustLocation.start(5);
            startKelas(jadwalId, int.parse(_latitude ?? "0"),
                    int.parse(_longitude ?? "0"))
                .then((value) => null);
          },
          child: const Icon(Icons.local_activity),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(
                top: 15.0, bottom: 290.0, left: 13.0, right: 13.0),
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              markers: Set<Marker>.of(_marker),
              onMapCreated: (controller) {
                _controller.complete(controller);
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Tedektsi Penggunaan Mock/FakeGps : $_isMockLocation'),
                        Text('Latitude: $_latitude, Longitude: $_longitude')
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

void requestLocationPermission() async {
  PermissionStatus permission =
      await LocationPermissions().requestPermissions();
  print('permissions: $permission');
}

void detek() {}
