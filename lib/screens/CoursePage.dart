import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterloc/model/ModelCourseDetail.dart';
import 'package:flutterloc/getcurrentlocation.dart';
import 'package:flutterloc/helper/Url.dart';
import 'package:flutterloc/trustloc.dart';

import '../model/Model.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late String token;
  late String chosenImg;
  late String chosenTitle;
  late String jadwalid;

  List<Widget> generateWidget(List<Silabus> dataBAP) {
    List<Widget> widgetSilabus = [];

    for (Silabus i in dataBAP) {
      widgetSilabus
          .add(productListing(i.pertemuan.toString(), i.materi, i.isActive));
    }
    return widgetSilabus;
  }

  Future<DataMateriJadwal> getData() async {
    var resp_dio = await Dio().get(
        'https://iteungdroid-dev.ulbi.ac.id/api/v1/akademik/kelas/dosen/jadwal/detail',
        options: Options(headers: {"Authorization": "Bearer $token"}),
        queryParameters: <String, String>{'jadwal_id': jadwalid});
    if (resp_dio.statusCode != 200) {
      throw Exception("Error");
    }
    DataDetailJadwal dataResponse = DataDetailJadwal.fromJson(resp_dio.data);

    return dataResponse.data;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    chosenImg = arguments['img'];
    chosenTitle = arguments['title'];
    jadwalid = arguments['jadwalid'];
    token = arguments['token'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffe1eaff),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff2657ce),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
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
            }
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$chosenTitle',
                    style: TextStyle(
                      color: Color(0xff2657ce),
                      fontSize: 27,
                    ),
                  ),
                  Text(
                    'Sarah Parknson',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromRGBO(255, 135, 0, 1),
                    ),
                    child: Hero(
                      tag: '$chosenImg',
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                              image: AssetImage('assets/image/$chosenImg.png'),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Course',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xffd3defa),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 35,
                              child: IconButton(
                                icon: Icon(
                                  Icons.timer,
                                  color: Colors.blue,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              "3 Hours, 20 Min",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: generateWidget(snapshot.data.materi),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Column productListing(String title, String info, String activeOrInactive) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: (activeOrInactive == 'active')
                    ? Color(0xff2657ce)
                    : Color(0xffd3defa),
                borderRadius: BorderRadius.all(Radius.circular(17)),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: (activeOrInactive == 'active')
                      ? Colors.white
                      : Color(0xff2657ce),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GetUserCurrentLocationScreen(
                              token: token, jadwalId: jadwalid)));
                },
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$info',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            )
          ],
        ),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.85,
            height: 0.5,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
