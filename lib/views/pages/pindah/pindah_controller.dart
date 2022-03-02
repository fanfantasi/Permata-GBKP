import 'package:anggota/models/models.dart';
import 'package:anggota/service/constants.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PindahController extends GetxController {
  RxBool loading = false.obs;
  RxBool submit = false.obs;
  RxBool loadingedit = false.obs;
  RxBool loadingrunggun = false.obs;
  final _service = Service();

  final tglController = TextEditingController();
  final nosuratController = TextEditingController();
  final remarksController = TextEditingController();
  RxString alasan = 'Bekerja'.obs;
  RxString klasis = ''.obs;
  RxString klasisid = ''.obs;
  RxString runggun = ''.obs;
  RxString runggunid = ''.obs;
  DateTime selectedDate = DateTime.now();

  void clearData() async {
    submit.value = false;
    alasan.value = 'Bekerja';
    tglController.clear();
    nosuratController.clear();
    remarksController.clear();
    alasan.value = '';
  }

  RxList<DataPindah> listpindah = <DataPindah>[].obs;
  Future<void> getPindah() async {
    try {
      loading.value = true;
      listpindah.clear();
      var pindah = await _service.getpindah(jenisid);
      if (pindah.status) {
        listpindah.value = pindah.data;
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  List<DataKlasis> listklasis = [];
  Future<bool> getKlasis() async {
    try {
      loadingedit.value = true;
      listklasis.clear();
      final result = await _service.getklasis();
      if (result.status) {
        listklasis = result.data;
        klasis.value = result.data[0].klasis;
        klasisid.value = result.data[0].id;
      }
      loadingedit.value = false;
      return true;
    } catch (e) {
      loadingedit.value = false;
      return false;
    }
  }

  List<DataRunggun> listrunggun = [];
  Future<void> getRunggun() async {
    try {
      loadingrunggun.value = true;
      listrunggun.clear();
      final result = await _service.getrunggun(klasisid.value);
      if (result.status) {
        listrunggun = result.data;
        runggun.value = result.data[0].runggun;
        runggunid.value = result.data[0].id;
      }
      loadingrunggun.value = false;
    } catch (e) {
      loadingrunggun.value = false;
    }
  }

  Future<void> submitPindah() async {
    try {
      submit.value = true;
      final result = await _service.postpindah(
          DateFormat('y-MM-dd').format(selectedDate),
          jenisid,
          klasisid.value,
          runggunid.value,
          alasan.value,
          nosuratController.text,
          remarksController.text);
      if (result.status) {
        Get.back();
        Get.snackbar('Info', result.message,
            colorText: Colors.white,
            snackStyle: SnackStyle.FLOATING,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Info',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
        getPindah();
      } else {
        Get.snackbar('Error', result.message,
            colorText: Colors.black,
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
}
