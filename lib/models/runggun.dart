class RunggunModel {
  RunggunModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataRunggun> data;

  RunggunModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => DataRunggun.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataRunggun {
  DataRunggun({
    required this.id,
    required this.runggun,
  });
  late final String id;
  late final String runggun;

  DataRunggun.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    runggun = json['runggun'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['runggun'] = runggun;
    return _data;
  }
}
