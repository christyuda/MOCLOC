// To parse this JSON data, do
//
//     final modelinfo = modelinfoFromMap(jsonString);

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Modelinfo modelinfoFromMap(String str) => Modelinfo.fromMap(json.decode(str));

String modelinfoToMap(Modelinfo data) => json.encode(data.toMap());

class Modelinfo {
  Modelinfo({
    required this.code,
    required this.success,
    required this.status,
    required this.data,
  });

  int code;
  bool success;
  String status;
  DataInfo data;

  factory Modelinfo.fromMap(Map<String, dynamic> json) => Modelinfo(
        code: json["code"],
        success: json["success"],
        status: json["status"],
        data: DataInfo.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "success": success,
        "status": status,
        "data": data.toMap(),
      };
}

class DataInfo {
  DataInfo({
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.prodi,
    required this.dosenWali,
  });

  String userId;
  String userName;
  String phoneNumber;
  String emailAddress;
  String prodi;
  String dosenWali;

  factory DataInfo.fromMap(Map<String, dynamic> json) => DataInfo(
        userId: json["user_id"],
        userName: json["user_name"],
        phoneNumber: json["phone_number"],
        emailAddress: json["email_address"],
        prodi: json["prodi"],
        dosenWali: json["dosen_wali"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "user_name": userName,
        "phone_number": phoneNumber,
        "email_address": emailAddress,
      };
}
