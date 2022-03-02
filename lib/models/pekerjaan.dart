class PekerjaanModel {
  PekerjaanModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataPekerjaan> data;

  PekerjaanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List.from(json['data']).map((e) => DataPekerjaan.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataPekerjaan {
  DataPekerjaan({
    required this.id,
    required this.pekerjaan,
  });
  late final String id;
  late final String pekerjaan;

  DataPekerjaan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pekerjaan = json['pekerjaan'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['pekerjaan'] = pekerjaan;
    return _data;
  }
}
