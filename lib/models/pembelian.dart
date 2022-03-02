class PembelianBukuModel {
  PembelianBukuModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataPembelian> data;

  PembelianBukuModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List.from(json['data']).map((e) => DataPembelian.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataPembelian {
  DataPembelian({
    required this.id,
    required this.jenis,
    required this.tahun,
    required this.notrans,
    required this.tglBeli,
    required this.fullName,
    required this.metode,
    required this.rek,
    required this.harga,
  });
  late final String id;
  late final String jenis;
  late final String tahun;
  late final String notrans;
  late final String tglBeli;
  late final String fullName;
  late final String metode;
  late final String rek;
  late final String harga;

  DataPembelian.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
    tahun = json['tahun'];
    notrans = json['notrans'];
    tglBeli = json['tgl_beli'];
    fullName = json['full_name'];
    metode = json['metode'];
    rek = json['rek'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['jenis'] = jenis;
    _data['tahun'] = tahun;
    _data['notrans'] = notrans;
    _data['tgl_beli'] = tglBeli;
    _data['full_name'] = fullName;
    _data['metode'] = metode;
    _data['rek'] = rek;
    _data['harga'] = harga;
    return _data;
  }
}
