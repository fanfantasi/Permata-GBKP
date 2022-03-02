class PendidikanModel {
  PendidikanModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataPendidikan> data;

  PendidikanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        List.from(json['data']).map((e) => DataPendidikan.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataPendidikan {
  DataPendidikan({
    required this.id,
    required this.pendidikan,
  });
  late final String id;
  late final String pendidikan;

  DataPendidikan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pendidikan = json['pendidikan'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['pendidikan'] = pendidikan;
    return _data;
  }
}
