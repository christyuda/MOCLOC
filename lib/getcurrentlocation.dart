import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trust_location/trust_location.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:trust_location/trust_location.dart';
import 'package:flutter/services.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _GetUserCurrentLocationScreenState createState() =>
      _GetUserCurrentLocationScreenState();
}

class _GetUserCurrentLocationScreenState
    extends State<GetUserCurrentLocationScreen> {
  String? _latitude;
  String? _longitude;
  bool? _isMockLocation;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.873183, 107.575944),
    zoom: 20,
  );

  final List<Marker> _marker = <Marker>[
    // Marker(
    //     markerId: MarkerId('1'),
    //     position: LatLng(-6.884938, 107.615420),
    //     infoWindow: InfoWindow(title: 'titik marker'))
  ];

  loadData() {
    getUserCurrentLocation().then((value) async {
      print('lokasiku');
      print(value.latitude.toString() + "" + value.longitude.toString());

      _marker.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'lokasiku')));

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
      print("erorr gais" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    TrustLocation.start(5);
    getLocation();
    requestLocationPermission();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadData();
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}

void requestLocationPermission() async {
  PermissionStatus permission =
      await LocationPermissions().requestPermissions();
  print('permissions: $permission');
}
