class PerpulungenModel {
  PerpulungenModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataPerpulungen> data;

  PerpulungenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data'])
        .map((e) => DataPerpulungen.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataPerpulungen {
  DataPerpulungen({
    required this.id,
    required this.perpulungen,
  });
  late final String id;
  late final String perpulungen;

  DataPerpulungen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    perpulungen = json['perpulungen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['perpulungen'] = perpulungen;
    return _data;
  }
}
