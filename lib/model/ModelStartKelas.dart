import 'dart:convert';

class MulaiKelas {
  MulaiKelas({
    required this.code,
    required this.success,
    required this.status,
    required this.data,
  });

  final int code;
  final bool success;
  final String status;
  final Data data;

  factory MulaiKelas.fromJson(String str) =>
      MulaiKelas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MulaiKelas.fromMap(Map<String, dynamic> json) => MulaiKelas(
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
    required this.jadwalId,
    required this.matakuliah,
    required this.kelas,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.pertemuan,
  });

  final String jadwalId;
  final String matakuliah;
  final String kelas;
  final String hari;
  final String jamMulai;
  final String jamSelesai;
  final int pertemuan;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        jadwalId: json["jadwal_id"],
        matakuliah: json["matakuliah"],
        kelas: json["kelas"],
        hari: json["hari"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        pertemuan: json["pertemuan"],
      );

  Map<String, dynamic> toMap() => {
        "jadwal_id": jadwalId,
        "matakuliah": matakuliah,
        "kelas": kelas,
        "hari": hari,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "pertemuan": pertemuan,
      };
}

class DataKelasMulai {
  DataKelasMulai({
    required this.jadwalId,
    required this.materiPerkuliahan,
    required this.position,
  });

  final String jadwalId;
  final String materiPerkuliahan;
  final PositionLoc position;

  factory DataKelasMulai.fromJson(String str) =>
      DataKelasMulai.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataKelasMulai.fromMap(Map<String, dynamic> json) => DataKelasMulai(
        jadwalId: json["jadwal_id"],
        materiPerkuliahan: json["materi_perkuliahan"],
        position: PositionLoc.fromMap(json["position"]),
      );

  Map<String, dynamic> toMap() => {
        "jadwal_id": jadwalId,
        "materi_perkuliahan": materiPerkuliahan,
        "position": position.toMap(),
      };
}

class PositionLoc {
  PositionLoc({
    required this.latitude,
    required this.longitude,
  });

  final int latitude;
  final int longitude;

  factory PositionLoc.fromJson(String str) =>
      PositionLoc.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PositionLoc.fromMap(Map<String, dynamic> json) => PositionLoc(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
