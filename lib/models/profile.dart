class ProfileModel {
  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final List<DataProfile> data;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e) => DataProfile.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataProfile {
  DataProfile({
    required this.photo,
    required this.email,
    required this.phone,
  });
  late final String photo;
  late final String email;
  late final String phone;

  DataProfile.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photo'] = photo;
    _data['email'] = email;
    _data['phone'] = phone;
    return _data;
  }
}
