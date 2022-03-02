class AnggotaModel {
  AnggotaModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataAnggota> data;
  late final List<Verif> verif;

  AnggotaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => DataAnggota.fromJson(e)).toList();
    verif = List.from(json['verif']).map((e) => Verif.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['verif'] = verif.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataAnggota {
  DataAnggota({
    required this.anggotaid,
    required this.nama,
    required this.email,
    required this.telp,
    required this.tempatLahir,
    required this.tglLahir,
    required this.klasis,
    required this.runggun,
    required this.perpulungen,
    required this.sttsAnggota,
    required this.status,
  });
  late final String anggotaid;
  late final String nama;
  late final String email;
  late final String telp;
  late final String tempatLahir;
  late final String tglLahir;
  late final Klasis? klasis;
  late final Runggun? runggun;
  late final Perpulungen? perpulungen;
  late final String sttsAnggota;
  late final String status;

  DataAnggota.fromJson(Map<String, dynamic> json) {
    anggotaid = json['anggotaid'];
    nama = json['nama'];
    email = json['email'];
    telp = json['telp'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
    klasis = json['klasis'] == null ? null : Klasis.fromJson(json['klasis']);
    runggun =
        json['runggun'] == null ? null : Runggun.fromJson(json['runggun']);
    perpulungen = json['perpulungen'] == null
        ? null
        : Perpulungen.fromJson(json['perpulungen']);

    sttsAnggota = json['stts_anggota'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['anggotaid'] = anggotaid;
    _data['nama'] = nama;
    _data['email'] = email;
    _data['telp'] = telp;
    _data['tempat_lahir'] = tempatLahir;
    _data['tgl_lahir'] = tglLahir;
    _data['klasis'] = klasis?.toJson();
    _data['runggun'] = runggun?.toJson();
    _data['perpulungen'] = perpulungen?.toJson();
    _data['stts_anggota'] = sttsAnggota;
    _data['status'] = status;
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

class Verif {
  Verif({
    required this.approveRunggun,
    required this.approveKlasis,
    required this.approveAdmin,
  });
  late final int approveRunggun;
  late final int approveKlasis;
  late final int approveAdmin;

  Verif.fromJson(Map<String, dynamic> json) {
    approveRunggun = json['approve_runggun'];
    approveKlasis = json['approve_klasis'];
    approveAdmin = json['approve_admin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['approve_runggun'] = approveRunggun;
    _data['approve_klasis'] = approveKlasis;
    _data['approve_admin'] = approveAdmin;
    return _data;
  }
}
