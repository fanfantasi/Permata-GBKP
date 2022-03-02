class TahunModel {
  TahunModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataTahun> data;

  TahunModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => DataTahun.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataTahun {
  DataTahun({
    required this.id,
    required this.tahun,
    required this.harga,
  });
  late final String id;
  late final String tahun;
  late final String harga;

  DataTahun.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tahun = json['tahun'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['tahun'] = tahun;
    _data['harga'] = harga;
    return _data;
  }
}
