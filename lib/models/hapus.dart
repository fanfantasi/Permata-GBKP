class HapusModel {
  HapusModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataHapus> data;

  HapusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => DataHapus.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataHapus {
  DataHapus({
    required this.id,
    required this.status,
    required this.remarks,
    required this.waktu,
    required this.validasi,
  });
  late final String id;
  late final String status;
  late final String remarks;
  late final String waktu;
  late final String validasi;

  DataHapus.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    status = json['status'];
    remarks = json['remarks'];
    waktu = json['waktu'];
    validasi = json['validasi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['status'] = status;
    _data['remarks'] = remarks;
    _data['waktu'] = waktu;
    _data['validasi'] = validasi;
    return _data;
  }
}
