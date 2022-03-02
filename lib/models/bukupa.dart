class BukuPAModel {
  BukuPAModel({
    required this.status,
    required this.conditional,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final int conditional;
  late final String message;
  late final List<DataBukuPA> data;

  BukuPAModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    conditional = json['conditional'];
    message = json['message'];
    data = List.from(json['data']).map((e) => DataBukuPA.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['conditional'] = conditional;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataBukuPA {
  DataBukuPA({
    required this.id,
    required this.tahun,
    required this.title,
    required this.file,
  });
  late final String id;
  late final String tahun;
  late final String title;
  late final String file;

  DataBukuPA.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    tahun = json['tahun'];
    title = json['title'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['tahun'] = tahun;
    _data['title'] = title;
    _data['file'] = file;
    return _data;
  }
}
