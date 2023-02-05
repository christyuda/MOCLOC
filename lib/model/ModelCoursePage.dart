import 'dart:convert';

class DataJadwal {
  DataJadwal({
    required this.code,
    required this.success,
    required this.status,
    required this.data,
  });

  int code;
  bool success;
  String status;
  Data data;

  factory DataJadwal.fromJson(String str) =>
      DataJadwal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataJadwal.fromMap(Map<String, dynamic> json) => DataJadwal(
        code: json["code"],
        success: json["success"],
        status: json["status"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "success": success,
        "status": status,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.jadwal,
  });

  List<Jadwal> jadwal;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        jadwal: List<Jadwal>.from(json["jadwal"].map((x) => Jadwal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "jadwal": List<dynamic>.from(jadwal.map((x) => x.toMap())),
      };
}

class Jadwal {
  Jadwal({
    required this.jadwalId,
    required this.matakuliah,
    required this.kelas,
    required this.hari,
  });

  String jadwalId;
  String matakuliah;
  String kelas;
  String hari;

  factory Jadwal.fromJson(String str) => Jadwal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Jadwal.fromMap(Map<String, dynamic> json) => Jadwal(
        jadwalId: json["jadwal_id"],
        matakuliah: json["matakuliah"],
        kelas: json["kelas"],
        hari: json["hari"],
      );

  Map<String, dynamic> toMap() => {
        "jadwal_id": jadwalId,
        "matakuliah": matakuliah,
        "kelas": kelas,
        "hari": hari,
      };
}
