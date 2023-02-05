import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterloc/helper/Url.dart';
import 'package:flutterloc/model/ModelCoursePage.dart';
import 'package:flutterloc/screens/CoursePage.dart';
import 'package:flutterloc/screens/ProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
      routes: {
        '/coursePage': (context) => CoursePage(),
      },
    );
  }
}

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  String token = "";
  String ref_token = "";
  List<Jadwal> jadwal = [];

  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) {
      setState(() {
        token = pref.getString("access_token")!;
        ref_token = pref.getString("refresh_token")!;
      });
    });
    getListJadwal().then((value) {
      setState(() {
        jadwal = value;
      });
    });
    super.initState();
  }

  Future<void> getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("access_token")!;
      ref_token = pref.getString("refresh_token")!;
    });
  }

  Future<List<Jadwal>> getListJadwal() async {
    var url = "${getBaseUrl()}akademik/kelas/dosen/jadwal";
    if (token == "") {
      await getCred();
    }

    try {
      var response = await Dio().get(
        url,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        var data = DataJadwal.fromMap(response.data);
        return data.data.jadwal;
      }
      throw Exception("error");
    } catch (error) {
      throw Exception("error");
    }
  }

  List<Widget> generateWidget(List<Jadwal> Listjadwal) {
    List<Widget> widget = [];
    for (Jadwal jadwal in Listjadwal) {
      var gambar = 'img${Listjadwal.indexOf(jadwal) + 1}';
      widget.add(courseWidget(
          jadwal.hari,
          jadwal.matakuliah,
          gambar,
          jadwal.jadwalId,
          Color.fromRGBO(25, 50, 180, 1),
          Color.fromRGBO(255, 135, 0, 1)));
      widget.add(SizedBox(
        height: 20,
      ));
    }
    return widget;
  }

  List<Container> generateContainer(List<Jadwal> jadwal) {
    List<Container> con = [];
    var middle = jadwal.length ~/ 2;

    var list1 = generateWidget(jadwal.sublist(0, middle));
    var list2 = generateWidget(jadwal.sublist(middle));

    con.add(Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list1,
      ),
    ));

    con.add(Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list2,
      ),
    ));

    return con;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f6fd),
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Hello Developers",
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/image/profilePic.png'))),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'What do you \nwant to \nlearn today?',
              style: TextStyle(
                  fontSize: 35, height: 1.3, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: generateContainer(jadwal),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.subscriptions,
                      color: Color(0xff2657ce),
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Color(0xff2657ce).withOpacity(0.5),
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(token: this.token)));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container courseWidget(String category, String title, String img,
      String jadwalID, Color categoryColor, Color bgColor) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () {
          openCoursePage(img, title, jadwalID, token);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                '$category',
                style: TextStyle(
                    color: (categoryColor == Color(0xffe9eefa)
                        ? Color(0xff2657ce)
                        : Colors.white)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$title',
              style: TextStyle(
                color: (bgColor == Color.fromRGBO(255, 135, 0, 1))
                    ? Colors.white
                    : Colors.black,
                fontSize: 20,
                height: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 5,
                  width: 100,
                  color: (bgColor == Color.fromRGBO(255, 135, 0, 1))
                      ? Colors.red
                      : Color(0xff2657ce),
                ),
                Expanded(
                  child: Container(
                    height: 5,
                    color: (bgColor == Color.fromRGBO(255, 135, 0, 1))
                        ? Colors.white.withOpacity(0.5)
                        : Color(0xff2657ce).withOpacity(0.5),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Hero(
            //   tag: img,
            //   child: Container(
            //     height: 80,
            //     decoration: BoxDecoration(
            //         image: DecorationImage(
            //       image: AssetImage('assets/image/$img.png'),
            //     )),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void openCoursePage(String img, String title, String jadwalID, String token) {
    Navigator.pushNamed(context, '/coursePage', arguments: {
      'token': token,
      'img': img,
      'title': title,
      'jadwalid': jadwalID
    });
  }
}
