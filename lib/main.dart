import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterloc/home_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutterloc/getcurrentlocation.dart';
import 'package:flutterloc/trustloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: trusloc(),
    );
  }
}
