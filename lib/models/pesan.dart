class PesanModel {
  PesanModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataPesan> data;

  PesanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => DataPesan.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataPesan {
  DataPesan({
    required this.id,
    required this.pesan,
  });
  late final String id;
  late final String pesan;

  DataPesan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pesan = json['pesan'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['pesan'] = pesan;
    return _data;
  }
}
