class KeanggotaanModel {
  KeanggotaanModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataKeanggotaan> data;

  KeanggotaanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data'])
        .map((e) => DataKeanggotaan.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataKeanggotaan {
  DataKeanggotaan({
    required this.id,
    required this.anggotaId,
    required this.noKtp,
    required this.fullName,
    required this.tmpLahir,
    required this.tglLahir,
    required this.gender,
    required this.perpulungen,
    required this.runggun,
    required this.klasis,
    required this.noTelp,
    required this.email,
    required this.sttsAnggota,
    required this.status,
    required this.idPekerjaan,
    required this.pendidikanId,
    required this.jurusan,
    required this.photo,
    required this.edit,
  });
  late final String id;
  late final String anggotaId;
  late final String noKtp;
  late final String fullName;
  late final String tmpLahir;
  late final String tglLahir;
  late final String gender;
  late final Klasis? klasis;
  late final Runggun? runggun;
  late final Perpulungen? perpulungen;
  late final String noTelp;
  late final String email;
  late final String sttsAnggota;
  late final String status;
  late final Pekerjaan? idPekerjaan;
  late final Pendidikan? pendidikanId;
  late final String jurusan;
  late final String photo;
  late final bool edit;

  DataKeanggotaan.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    anggotaId = json['anggota_id'];
    noKtp = json['no_ktp'];
    fullName = json['full_name'];
    tmpLahir = json['tmp_lahir'];
    tglLahir = json['tgl_lahir'];
    gender = json['gender'];
    klasis = json['klasis'] == null ? null : Klasis.fromJson(json['klasis']);
    runggun =
        json['runggun'] == null ? null : Runggun.fromJson(json['runggun']);
    perpulungen = json['perpulungen'] == null
        ? null
        : Perpulungen.fromJson(json['perpulungen']);
    idPekerjaan = json['id_pekerjaan'] == null
        ? null
        : Pekerjaan.fromJson(json['id_pekerjaan']);
    noTelp = json['no_telp'];
    email = json['email'];
    sttsAnggota = json['stts_anggota'];
    status = json['status'];
    pendidikanId = json['pendidikan_id'] == null
        ? null
        : Pendidikan.fromJson(json['pendidikan_id']);
    jurusan = json['jurusan'];
    photo = json['photo'];
    edit = json['edit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['anggota_id'] = anggotaId;
    _data['no_ktp'] = noKtp;
    _data['full_name'] = fullName;
    _data['tmp_lahir'] = tmpLahir;
    _data['tgl_lahir'] = tglLahir;
    _data['gender'] = gender;
    _data['klasis'] = klasis?.toJson();
    _data['runggun'] = runggun?.toJson();
    _data['perpulungen'] = perpulungen?.toJson();
    _data['no_telp'] = noTelp;
    _data['email'] = email;
    _data['stts_anggota'] = sttsAnggota;
    _data['status'] = status;
    _data['id_pekerjaan'] = idPekerjaan?.toJson();
    _data['pendidikan_id'] = pendidikanId?.toJson();
    _data['jurusan'] = jurusan;
    _data['photo'] = photo;
    _data['edit'] = edit;
    return _data;
  }
}

class Klasis {
  Klasis({
    required this.id,
    required this.klasis,
  });
  late final String id;
  late final String klasis;

  Klasis.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    klasis = json['klasis'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['klasis'] = klasis;
    return _data;
  }
}

class Runggun {
  Runggun({
    required this.id,
    required this.klasisId,
    required this.runggun,
  });
  late final String id;
  late final String klasisId;
  late final String runggun;

  Runggun.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    klasisId = json['klasis_id'];
    runggun = json['runggun'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['klasis_id'] = klasisId;
    _data['runggun'] = runggun;
    return _data;
  }
}

class Perpulungen {
  Perpulungen({
    required this.id,
    required this.perpulungen,
  });
  late final String id;
  late final String perpulungen;

  Perpulungen.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    perpulungen = json['perpulungen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['perpulungen'] = perpulungen;
    return _data;
  }
}

class Pekerjaan {
  Pekerjaan({
    required this.id,
    required this.nmpekerjaan,
  });
  late final String id;
  late final String nmpekerjaan;

  Pekerjaan.fromJson(Map<String, dynamic> json) {
    id = json['id_pekerjaan'];
    nmpekerjaan = json['nm_pekerjaan'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_pekerjaan'] = id;
    _data['nm_pekerjaan'] = nmpekerjaan;
    return _data;
  }
}

class Pendidikan {
  Pendidikan({
    required this.id,
    required this.pendidikan,
  });
  late final String id;
  late final String pendidikan;

  Pendidikan.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    pendidikan = json['pendidikan'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['pendidikan'] = pendidikan;
    return _data;
  }
}
