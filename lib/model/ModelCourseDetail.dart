import 'dart:convert';

class DataDetailJadwal {
  DataDetailJadwal({
    required this.code,
    required this.success,
    required this.status,
    required this.data,
  });

  final int code;
  final bool success;
  final String status;
  final DataMateriJadwal data;

  factory DataDetailJadwal.fromRawJson(String str) =>
      DataDetailJadwal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataDetailJadwal.fromJson(Map<String, dynamic> json) =>
      DataDetailJadwal(
        code: json["code"],
        success: json["success"],
        status: json["status"],
        data: DataMateriJadwal.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "status": status,
        "data": data.toJson(),
      };
}

class DataMateriJadwal {
  DataMateriJadwal({
    required this.jadwalId,
    required this.matakuliah,
    required this.kelas,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.ruangan,
    required this.rencanaKehadiran,
    required this.kehadiran,
    required this.available,
    required this.materi,
  });

  final String jadwalId;
  final String matakuliah;
  final String kelas;
  final String hari;
  final String jamMulai;
  final String jamSelesai;
  final String ruangan;
  final int rencanaKehadiran;
  final int kehadiran;
  final bool available;
  final List<Silabus> materi;

  factory DataMateriJadwal.fromRawJson(String str) =>
      DataMateriJadwal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataMateriJadwal.fromJson(Map<String, dynamic> json) =>
      DataMateriJadwal(
        jadwalId: json["jadwal_id"],
        matakuliah: json["matakuliah"],
        kelas: json["kelas"],
        hari: json["hari"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        ruangan: json["ruangan"],
        rencanaKehadiran: json["rencana_kehadiran"],
        kehadiran: json["kehadiran"],
        available: json["available"],
        materi:
            List<Silabus>.from(json["materi"].map((x) => Silabus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jadwal_id": jadwalId,
        "matakuliah": matakuliah,
        "kelas": kelas,
        "hari": hari,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "ruangan": ruangan,
        "rencana_kehadiran": rencanaKehadiran,
        "kehadiran": kehadiran,
        "available": available,
        "materi": List<dynamic>.from(materi.map((x) => x.toJson())),
      };
}

class Silabus {
  Silabus(
      {required this.pertemuan, required this.materi, required this.isActive});

  final int pertemuan;
  final String materi;
  final String isActive;

  factory Silabus.fromRawJson(String str) => Silabus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Silabus.fromJson(Map<String, dynamic> json) => Silabus(
      pertemuan: json["pertemuan"],
      materi: json["materi"],
      isActive: json["is_active"]);

  Map<String, dynamic> toJson() =>
      {"pertemuan": pertemuan, "materi": materi, "is_active": isActive};
}
