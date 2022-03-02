class SliderModel {
  SliderModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<DataSlider> data;

  SliderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => DataSlider.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataSlider {
  DataSlider({
    required this.id,
    required this.file,
  });
  late final String id;
  late final String file;

  DataSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['file'] = file;
    return _data;
  }
}
