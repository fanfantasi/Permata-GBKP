class RekeningModel {
  RekeningModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataRekening> data;

  RekeningModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List.from(json['data']).map((e) => DataRekening.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataRekening {
  DataRekening({
    required this.id,
    required this.nama,
    required this.perusahaan,
    required this.rek,
  });
  late final String id;
  late final String nama;
  late final String perusahaan;
  late final String rek;

  DataRekening.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    perusahaan = json['perusahaan'];
    rek = json['rek'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    _data['perusahaan'] = perusahaan;
    _data['rek'] = rek;
    return _data;
  }
}
