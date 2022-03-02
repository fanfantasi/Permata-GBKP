import 'dart:convert';

import 'package:anggota/models/models.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class SigninController extends GetxController {
  RxBool loading = false.obs;
  RxBool submit = false.obs;
  RxBool loadingbox = false.obs;
  final usernameController = TextEditingController();
  final emailresertController = TextEditingController();
  final passwordController = TextEditingController();
  final _service = Service();

  RxString gender = 'L'.obs;
  RxString klasisname = ''.obs;
  RxString klasisid = ''.obs;

  RxString runggunname = ''.obs;
  RxString runggunid = ''.obs;

  RxString perpulungenname = ''.obs;
  RxString perpulungenid = ''.obs;
  RxString sttsAnggota = '0'.obs;
  RxString status = '1'.obs;
  RxString photo = ''.obs;
  RxBool emptyphoto = true.obs;
  RxString pekerjaan = ''.obs;
  RxString pekerjaanid = ''.obs;
  RxString pendidikan = ''.obs;
  RxString pendidikanid = ''.obs;
  DateTime selectedDate = DateTime.now();

  final nikController = TextEditingController();
  final usernamesigninController = TextEditingController();
  final namalengkapController = TextEditingController();
  final tmplahirController = TextEditingController();
  final tgllahirController = TextEditingController();
  final telpController = TextEditingController();
  final emailController = TextEditingController();
  final jurusanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    usernameController.clear();
    passwordController.clear();
  }

  Future<void> submitResert() async {
    try {
      submit.value = true;
      final result = await _service.resertPassword(emailresertController.text);
      if (result.status) {
        Get.back();
        Get.snackbar('Info', result.message,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Info',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      } else {
        Get.snackbar('Error', result.message,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      }
      submit.value = false;
    } catch (e) {
      submit.value = false;
    }
  }

  Future<void> submitRegistrasi(file) async {
    try {
      submit.value = true;
      final result = await _service.postregistrasi(
          nikController.text,
          usernamesigninController.text,
          namalengkapController.text,
          tmplahirController.text,
          DateFormat('y-MM-dd').format(selectedDate),
          gender.value,
          telpController.text,
          emailController.text,
          klasisid.value,
          runggunid.value,
          perpulungenid.value,
          sttsAnggota.value,
          status.value,
          pekerjaanid.value,
          pendidikanid.value,
          jurusanController.text,
          passwordController.text,
          file);
      if (result.status) {
        Get.back();
        Get.snackbar('Info', result.message,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Info',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      } else {
        Get.snackbar('Error', result.message,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      }
      submit.value = false;
    } catch (e) {
      submit.value = false;
    }
  }

  void signIn() async {
    try {
      loading.value = true;
      final result = await _service.getLogin(
          usernameController.text, passwordController.text);
      if (result.data[0].value != 0) {
        await GetStorage.init();
        final box = Get.find<GetStorage>();
        loading.value = false;
        final session = jsonEncode(result.data);
        await box.write('user', json.decode(session));
        await box.write('photo', result.data[0].photo);
        await box.write('email', result.data[0].email);
        await box.write('fullname', result.data[0].fullName);
        await Get.offAllNamed("/home", arguments: json.decode(session));
      } else {
        loading.value = false;
        Get.snackbar('Error', result.data[0].message,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      }
    } catch (e) {
      loading.value = false;
    }
  }

  List<DataKlasis> listklasis = [];
  Future<void> getKlasis() async {
    try {
      loadingbox.value = true;
      listklasis.clear();
      final result = await _service.getklasis();
      if (result.status) {
        listklasis = result.data;
        klasisname.value = listklasis[0].klasis;
        klasisid.value = listklasis[0].id;
      }
      loadingbox.value = false;
    } catch (e) {
      loadingbox.value = false;
    }
  }

  List<DataRunggun> listrunggun = [];
  Future<void> getrunggun() async {
    try {
      loadingbox.value = true;
      listrunggun.clear();
      final result = await _service.getrunggun(klasisid.value);
      if (result.status) {
        listrunggun = result.data;
        runggunname.value = listrunggun[0].runggun;
        runggunid.value = listrunggun[0].id;
      }
      loadingbox.value = false;
    } catch (e) {
      loadingbox.value = false;
    }
  }

  List<DataPerpulungen> listperpulungen = [];
  Future<void> getPerulungen() async {
    try {
      loadingbox.value = true;
      listperpulungen.clear();
      final result =
          await _service.getperpulungan(klasisid.value, runggunid.value);
      if (result.status) {
        listperpulungen = result.data;
        perpulungenname.value = listperpulungen[0].perpulungen;
        perpulungenid.value = listperpulungen[0].id;
      }
      loadingbox.value = false;
    } catch (e) {
      loadingbox.value = false;
    }
  }

  List<DataPekerjaan> listpekerjaan = [];
  Future<void> getPekerjaan() async {
    try {
      loadingbox.value = true;
      listpekerjaan.clear();
      final result = await _service.getpekerjaan();
      if (result.status) {
        listpekerjaan = result.data;
        pekerjaan.value = listpekerjaan[0].pekerjaan;
        pekerjaanid.value = listpekerjaan[0].id;
      }
      loadingbox.value = false;
    } catch (e) {
      loadingbox.value = false;
    }
  }

  List<DataPendidikan> listpendidikan = [];
  Future<void> getPendidikan() async {
    try {
      loadingbox.value = true;
      listpendidikan.clear();
      final result = await _service.getpendidikan();
      if (result.status) {
        listpendidikan = result.data;
        pendidikan.value = listpendidikan[0].pendidikan;
        pendidikanid.value = listpendidikan[0].id;
      }
      loadingbox.value = false;
    } catch (e) {
      loadingbox.value = false;
    }
  }
}
