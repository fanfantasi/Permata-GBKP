class BukuptigartModel {
  BukuptigartModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataPtigart> data;

  BukuptigartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => DataPtigart.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataPtigart {
  DataPtigart({
    required this.id,
    required this.jenis,
    required this.title,
    required this.tahun,
    required this.notrans,
    required this.tglBeli,
    required this.fullName,
    required this.metode,
    required this.rek,
    required this.harga,
    required this.status,
    required this.file,
  });
  late final String id;
  late final String jenis;
  late final String title;
  late final String tahun;
  late final String notrans;
  late final String tglBeli;
  late final String fullName;
  late final String metode;
  late final String rek;
  late final String harga;
  late final String status;
  late final String file;

  DataPtigart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
    tahun = json['tahun'];
    title = json['title'];
    notrans = json['notrans'];
    tglBeli = json['tgl_beli'];
    fullName = json['full_name'];
    metode = json['metode'];
    rek = json['rek'];
    harga = json['harga'];
    status = json['status'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['jenis'] = jenis;
    _data['title'] = title;
    _data['tahun'] = tahun;
    _data['notrans'] = notrans;
    _data['tgl_beli'] = tglBeli;
    _data['full_name'] = fullName;
    _data['metode'] = metode;
    _data['rek'] = rek;
    _data['harga'] = harga;
    _data['status'] = status;
    _data['file'] = file;
    return _data;
  }
}
