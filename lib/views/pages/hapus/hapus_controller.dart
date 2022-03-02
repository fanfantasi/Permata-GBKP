import 'package:anggota/models/models.dart';
import 'package:anggota/service/constants.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HapusController extends GetxController {
  RxBool loading = false.obs;
  RxBool submit = false.obs;
  DateTime selectedDate = DateTime.now();
  final _service = Service();
  final tglController = TextEditingController();
  final nosuratController = TextEditingController();
  final remarksController = TextEditingController();
  RxString alasan = ''.obs;

  void clearData() async {
    submit.value = false;
    alasan.value = 'BEKERJA';
    tglController.clear();
    nosuratController.clear();
    remarksController.clear();
    alasan.value = '';
  }

  RxList<DataHapus> listhapus = <DataHapus>[].obs;
  Future<void> getHapus() async {
    try {
      loading.value = true;
      listhapus.clear();
      var hapus = await _service.gethapus(jenisid);
      if (hapus.status) {
        listhapus.value = hapus.data;
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> submitHapus() async {
    try {
      submit.value = true;
      final result = await _service.posthapus(
          DateFormat('y-MM-dd').format(selectedDate),
          jenisid,
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
        getHapus();
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
