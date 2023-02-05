import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterloc/screens/ProfileBodyScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.token});

  String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil',
            style: GoogleFonts.poppins(
              color: Color(0x00954848),
              fontWeight: FontWeight.w600,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Color(0xff484848),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: ProfileBody(token: this.token),
    );
  }
}
