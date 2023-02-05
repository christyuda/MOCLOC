import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterloc/Loginscreen.dart';
import 'Onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), openOnBoard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/images/bg.png'))),
        child: Center(
            child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('asset/images/logo.png'))),
        )),
      ),
    );
  }

  void openOnBoard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginapp()),
    );
  }
}
