import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutterloc/helper/Url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:uno/uno.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:flutterloc/screens/MainPage.dart';

class loginapp extends StatelessWidget {
  const loginapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITEUNG ANDROID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePageloginapp(),
    );
  }
}

class MyHomePageloginapp extends StatefulWidget {
  @override
  _MyHomePageloginapp createState() => _MyHomePageloginapp();
}

class _MyHomePageloginapp extends State<MyHomePageloginapp> {
  var phoneController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone_android)),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.password)),
              ),
              SizedBox(
                height: 45,
              ),
              OutlinedButton.icon(
                  onPressed: () {
                    login();
                  },
                  icon: Icon(
                    Icons.login,
                    size: 18,
                  ),
                  label: Text("LOGIN"))
            ],
          ),
        )),
      ),
    );
  }

  Future<void> login() async {
    if (passController.text.isNotEmpty && phoneController.text.isNotEmpty) {
      String url = '${getBaseUrl()}login';
      var ResponseDIO = await Dio().post(url, data: {
        'phone_number': phoneController.text,
        'password': passController.text
      });
      if (ResponseDIO.statusCode == 200) {
        final body = ResponseDIO.data;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Token : ${body['data']['token']}")));

        pageRoute(body['data']['token']);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ResponseDIO.data.status)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("pastikan diisi dlu sebelum login")));
    }
  }

  void pageRoute(Map token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("access_token", token['access_token']);
    await pref.setString("refresh_token", token['refresh_token']);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
