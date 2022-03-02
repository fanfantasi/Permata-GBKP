import 'dart:convert';
import 'package:anggota/models/keanggotaan.dart';
import 'package:anggota/models/listtrans.dart';
import 'package:anggota/models/models.dart';
import 'package:anggota/models/pesan.dart';
import 'package:anggota/models/profile.dart';
import 'package:dio/dio.dart';

class Service {
  var dio = Dio();
  final server = 'https://anggota.permatagbkp.org/';
  final apiKey = '1e957ebc35631ab22d5bd6526bd14ea2';

  //Get Login
  Future<UserModel> getLogin(String username, String password) async {
    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'password': password,
      });
      final response = await dio.post(server + 'mobile/api/login',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get login");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  //Get Login
  Future<AnggotaModel> getAnggota(jenisid) async {
    try {
      FormData formData = FormData.fromMap({
        'jenisid': jenisid,
      });
      final response = await dio.post(server + 'mobile/api/informasi',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return AnggotaModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get anggota");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<KeanggotaanModel> getKeanggota(jenisid) async {
    try {
      FormData formData = FormData.fromMap({
        'jenisid': jenisid,
      });
      final response = await dio.post(server + 'mobile/api/anggota',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return KeanggotaanModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get anggota");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  //Get Klasis
  Future<KlasisModel> getklasis() async {
    try {
      final response = await dio.get(server + 'mobile/api/klasis',
          options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return KlasisModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get klasis");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<RunggunModel> getrunggun(klasisid) async {
    try {
      FormData formData = FormData.fromMap({
        'klasisid': klasisid,
      });
      final response = await dio.post(server + 'mobile/api/runggun',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return RunggunModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get runggun");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PerpulungenModel> getperpulungan(klasisid, runggunid) async {
    try {
      FormData formData = FormData.fromMap({
        'klasisid': klasisid,
        'runggunid': runggunid,
      });
      final response = await dio.post(server + 'mobile/api/perpulungen',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PerpulungenModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get perpulungen");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  //Get Pekerjaan
  Future<PekerjaanModel> getpekerjaan() async {
    try {
      final response = await dio.get(server + 'mobile/api/pekerjaan',
          options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PekerjaanModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get klasis");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  //Get Pekerjaan
  Future<PendidikanModel> getpendidikan() async {
    try {
      final response = await dio.get(server + 'mobile/api/pendidikan',
          options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PendidikanModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get klasis");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<SliderModel> getslider() async {
    try {
      final response = await dio.get(server + 'mobile/api/slider',
          options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return SliderModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get klasis");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PostModel> postanggota(id, telp, email, sttsanggota, status, pekerjaan,
      pendidikan, jurusan, photo) async {
    try {
      FormData formData;
      if (photo != null) {
        String fileName = photo.split('/').last;
        formData = FormData.fromMap({
          'id': id,
          'telp': telp,
          'email': email,
          'sttsanggota': sttsanggota,
          'status': status,
          'pekerjaan': pekerjaan,
          'pendidikan': pendidikan,
          'jurusan': jurusan,
          'photo': await MultipartFile.fromFile(photo, filename: fileName),
        });
      } else {
        formData = FormData.fromMap({
          'id': id,
          'telp': telp,
          'email': email,
          'sttsanggota': sttsanggota,
          'status': status,
          'pekerjaan': pekerjaan,
          'pendidikan': pendidikan,
          'jurusan': jurusan,
          'photo': '',
        });
      }

      final response = await dio.post(server + 'mobile/api/editanggota',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw Exception("Failled to update anggota");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PostModel> postregistrasi(
      ktp,
      username,
      name,
      tmplahir,
      tgllahir,
      gender,
      telp,
      email,
      klasis,
      runggun,
      perpulungen,
      sttsanggota,
      status,
      pekerjaan,
      pendidikan,
      jurusan,
      password,
      photo) async {
    try {
      FormData formData;
      if (photo != null) {
        String fileName = photo.split('/').last;
        formData = FormData.fromMap({
          'no_ktp': ktp,
          'username': username,
          'full_name': name,
          'tmp_lahir': tmplahir,
          'tgl_lahir': tgllahir,
          'gender': gender,
          'no_telp': telp,
          'email': email,
          'klasis': klasis,
          'runggun': runggun,
          'perpulungen': perpulungen,
          'stts_anggota': sttsanggota,
          'stts': status,
          'pekerjaan': pekerjaan,
          'pendidikan': pendidikan,
          'jurusan': jurusan,
          'password': password,
          'photo': await MultipartFile.fromFile(photo, filename: fileName),
        });
      } else {
        formData = FormData.fromMap({
          'no_ktp': ktp,
          'username': username,
          'full_name': name,
          'tmp_lahir': tmplahir,
          'tgl_lahir': tgllahir,
          'gender': gender,
          'no_telp': telp,
          'email': email,
          'klasis': klasis,
          'runggun': runggun,
          'perpulungen': perpulungen,
          'stts_anggota': sttsanggota,
          'stts': status,
          'pekerjaan': pekerjaan,
          'pendidikan': pendidikan,
          'jurusan': jurusan,
          'password': password,
          'photo': '',
        });
      }
      final response = await dio.post(server + 'mobile/api/registrasi',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw Exception("Failled to registrasi anggota");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PindahModel> getpindah(anggotaid) async {
    try {
      FormData formData = FormData.fromMap({
        'jenisid': anggotaid,
      });
      final response = await dio.post(server + 'mobile/api/pindah',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PindahModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PostModel> postpindah(
    tgl,
    jenisid,
    klasis,
    runggun,
    alasan,
    nosurat,
    remarks,
  ) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'tgl': tgl,
        'jenisid': jenisid,
        'klasis': klasis,
        'runggun': runggun,
        'alasan': alasan,
        'no_surat': nosurat,
        'remarks': remarks
      });
      final response = await dio.post(server + 'mobile/api/postPindah',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw Exception("Failled to Pindah anggota");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<HapusModel> gethapus(anggotaid) async {
    try {
      FormData formData = FormData.fromMap({
        'jenisid': anggotaid,
      });
      final response = await dio.post(server + 'mobile/api/hapus',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return HapusModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PostModel> posthapus(
    tgl,
    jenisid,
    alasan,
    nosurat,
    remarks,
  ) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'tgl': tgl,
        'jenisid': jenisid,
        'alasan': alasan,
        'no_surat': nosurat,
        'remarks': remarks
      });
      final response = await dio.post(server + 'mobile/api/postHapus',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw Exception("Failled to Pindah anggota");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<BukuPAModel> getbukupa(anggotaid, tahun) async {
    try {
      FormData formData =
          FormData.fromMap({'jenisid': anggotaid, 'tahun': tahun});
      final response = await dio.post(server + 'mobile/api/tahunbuku',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return BukuPAModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<TahunModel> gettahun(tahun) async {
    try {
      FormData formData = FormData.fromMap({'tahun': tahun});
      final response = await dio.post(server + 'mobile/api/tahun',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return TahunModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<RekeningModel> getrekening() async {
    try {
      final response = await dio.get(server + 'mobile/api/metodepebayaran',
          options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return RekeningModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PembelianBukuModel> getpembalian(id, jenis) async {
    try {
      FormData formData = FormData.fromMap({'id': id, 'jenisbuku': jenis});
      final response = await dio.post(server + 'mobile/api/pembelianbukubyid',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PembelianBukuModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PesanModel> getpesan() async {
    try {
      final response = await dio.get(server + 'mobile/api/pesan',
          options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PesanModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<TransaksiModel> getpemesanan(
      tgl, anggotaid, jenis, tahunid, harga) async {
    try {
      FormData formData = FormData.fromMap({
        'tgl': tgl,
        'jenisid': anggotaid,
        'jenis': jenis,
        'tahun': tahunid,
        'harga': harga
      });
      final response = await dio.post(server + 'mobile/api/pembelian',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return TransaksiModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<TransaksiModel> getpembayaran(metode, transid) async {
    try {
      FormData formData =
          FormData.fromMap({'metode': metode, 'notrans': transid});
      final response = await dio.post(server + 'mobile/api/pembayaran',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return TransaksiModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<ListTransaksiModel> getlisttransaksi(jenisid) async {
    try {
      FormData formData = FormData.fromMap({'id': jenisid});
      final response = await dio.post(server + 'mobile/api/listtransaksi',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return ListTransaksiModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<TransaksiModel> sumitbukti(notrans, nama, email, tglbayar, jmlbayar,
      nmbank, norek, pesan, file) async {
    try {
      FormData formData;
      if (file != null) {
        String fileName = file.split('/').last;
        formData = FormData.fromMap({
          'notrans': notrans,
          'nama': nama,
          'email': email,
          'tglbayar': tglbayar,
          'jmlbayar': jmlbayar,
          'nmbank': nmbank,
          'norek': norek,
          'pesan': pesan,
          'bukti': await MultipartFile.fromFile(file, filename: fileName),
        });
      } else {
        formData = FormData.fromMap({
          'notrans': notrans,
          'nama': nama,
          'email': email,
          'tglbayar': tglbayar,
          'jmlbayar': jmlbayar,
          'nmbank': nmbank,
          'norek': norek,
          'pesan': pesan,
          'bukti': '',
        });
      }
      final response = await dio.post(server + 'mobile/api/pembayarantransaksi',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return TransaksiModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<BukuptigartModel> getbukup3rt(jenisid) async {
    try {
      FormData formData = FormData.fromMap({'jenisid': jenisid});
      final response = await dio.post(
          server + 'mobile/api/pembelianbukup3rtbyid',
          data: formData,
          options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return BukuptigartModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Pindah");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PostModel> changepassword(uid, oldpassword, password) async {
    try {
      FormData formData;
      formData = FormData.fromMap(
          {'uid': uid, 'oldpassword': oldpassword, 'password': password});
      final response = await dio.post(server + 'mobile/api/changepassword',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw Exception("Failled to Pindah anggota");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<ProfileModel> sumitprofile(uid, email, telp, file) async {
    try {
      FormData formData;
      if (file != null) {
        String fileName = file.path.split('/').last;
        formData = FormData.fromMap({
          'uid': uid,
          'email': email,
          'phone': telp,
          'photo': await MultipartFile.fromFile(file.path, filename: fileName),
        });
      } else {
        formData = FormData.fromMap(
            {'uid': uid, 'email': email, 'phone': telp, 'photo': ''});
      }
      final response = await dio.post(server + 'mobile/api/changeprofile',
          data: formData, options: Options(headers: {'x-api-key': apiKey}));
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception("Failled to get Profil");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw Exception("Server sedang sibuk");
      } else {
        throw Exception("Koneksi internet terputus");
      }
    }
  }

  Future<PostModel> resertPassword(email) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'email': email,
      });

      final response = await dio.post(server + 'mobile/api/resetpassword',
          data: formData,
          options: Options(
            headers: {'x-api-key': apiKey},
          ));
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw Exception("Failled to update anggota");
      }
    } on DioError catch (e) {
      var jsonString =
          '{"status": true, "message": "Sukses! Kami telah mengirimkan link reset password ke email anda."}';
      Map<String, dynamic> userMap = jsonDecode(jsonString);
      return PostModel.fromJson(userMap);
    }
  }
}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
