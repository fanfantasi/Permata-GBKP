class KlasisModel {
  KlasisModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataKlasis> data;

  KlasisModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => DataKlasis.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataKlasis {
  DataKlasis({
    required this.id,
    required this.klasis,
  });
  late final String id;
  late final String klasis;
  DataKlasis.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    klasis = json['klasis'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['klasis'] = klasis;
    return _data;
  }
}
