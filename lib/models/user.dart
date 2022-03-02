class UserModel {
  UserModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<Data> data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.value,
    required this.id,
    required this.message,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.photo,
    required this.isjenis,
    required this.islevel,
    required this.jenisid,
  });
  late final int value;
  late final String id;
  late final String message;
  late final String username;
  late final String email;
  late final String fullName;
  late final String phone;
  late final String photo;
  late final String isjenis;
  late final String islevel;
  late final String jenisid;

  Data.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    id = json['id'];
    message = json['message'];
    username = json['username'];
    email = json['email'];
    fullName = json['full_name'];
    phone = json['phone'];
    photo = json['photo'];
    isjenis = json['isjenis'];
    islevel = json['islevel'];
    jenisid = json['jenisid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['id'] = id;
    _data['message'] = message;
    _data['username'] = username;
    _data['email'] = email;
    _data['full_name'] = fullName;
    _data['phone'] = phone;
    _data['photo'] = photo;
    _data['isjenis'] = isjenis;
    _data['islevel'] = islevel;
    _data['jenisid'] = jenisid;
    return _data;
  }
}
