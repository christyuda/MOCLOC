import 'dart:convert';
import 'package:flutterloc/helper/Url.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:flutterloc/model/Model.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({Key? key, required this.token}) : super(key: key);

  final String token;

  Future<DataInfo> getData() async {
    String url = "${getBaseUrl()}user/info";
    var resp_dio = await Dio().get(
      url,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    if (resp_dio.statusCode != 200) {
      throw Exception("Error");
    }
    Modelinfo dataResponse = Modelinfo.fromMap(resp_dio.data);

    return dataResponse.data;
  }

  @override
  Widget build(BuildContext context) {
    // SharedPreferences.getInstance().then((value) => this.prefs);

    bool _isLoading = false;

    var lightgrey =
        GoogleFonts.poppins(fontSize: 12.0, color: const Color(0xf484848));

    var textcard = GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );
    var lighttextcard = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 4),
                )
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
              color: Color(0xffee8301),
            ),
            child: const CircleAvatar(
                backgroundImage: AssetImage("assets/image/avatar.jpg"),
                radius: 50.0),
          ),
          Text(
            " ",
            style: GoogleFonts.poppins(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff484848),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffee8301),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: FutureBuilder<DataInfo>(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    Fluttertoast.showToast(msg: snapshot.hasError.toString());
                  }

                  return Column(
                    children: [
                      const Divider(color: Colors.white),
                      Row(
                        children: [
                          Text("Nama", style: textcard),
                          const Spacer(),
                          Text(snapshot.data.userName, style: lighttextcard),
                          const SizedBox(width: 5.0),
                        ],
                      ),
                      const Divider(color: Colors.white),
                      Row(
                        children: [
                          Text("Kode ID", style: textcard),
                          const Spacer(),
                          Text(snapshot.data.userId, style: lighttextcard),
                          const SizedBox(width: 5.0),
                          Icon(Icons.copy, color: Colors.white, size: 18.0),
                        ],
                      ),
                      const Divider(color: Colors.white),
                      Row(
                        children: [
                          Text("Status Keaktifan", style: textcard),
                          const Spacer(),
                          Text(
                            "Aktif",
                            style: lighttextcard,
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white),
                      Row(
                        children: [
                          Text("Jenjang Prodi", style: textcard),
                          const Spacer(),
                          Text(snapshot.data.prodi, style: lighttextcard),
                        ],
                      ),
                      const Divider(color: Colors.white),
                      Row(
                        children: [
                          Text("Email", style: textcard),
                          const Spacer(),
                          Text(snapshot.data.emailAddress,
                              style: lighttextcard),
                        ],
                      ),
                      const Divider(color: Colors.white),
                      Row(
                        children: [
                          Text("No Telepon", style: textcard),
                          const Spacer(),
                          Text(snapshot.data.phoneNumber, style: lighttextcard),
                        ],
                      ),
                      const Divider(color: Colors.white),
                      Row(
                        children: [
                          Text("Dosen Wali", style: textcard),
                          const Spacer(),
                          Text(snapshot.data.dosenWali, style: lighttextcard),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}


// Future<String> getCred() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   var token = pref.getString("access_token")!;
//   if (token == null) {
//     return '';
//   }
//   return token;
// }


