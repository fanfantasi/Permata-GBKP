import 'package:anggota/models/listtrans.dart';
import 'package:anggota/service/constants.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UploadController extends GetxController {
  final _service = Service();
  RxBool loading = false.obs;
  RxString photo = ''.obs;
  RxBool emptyphoto = true.obs;
  RxBool submit = false.obs;
  RxString notrans = ''.obs;
  RxString jenis = ''.obs;
  RxInt harga = 0.obs;
  RxString rek = ''.obs;

  DateTime selectedDate = DateTime.now();
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final jmlController = TextEditingController();
  final bankController = TextEditingController();
  final hargaController = TextEditingController();
  final norekController = TextEditingController();
  final tglController = TextEditingController();
  final notransController = TextEditingController();
  final pesanController = TextEditingController();

  List<DataListTransaksi> listtransaksi = [];
  Future<void> getListTransaksi() async {
    try {
      loading.value = true;
      var res = await _service.getlisttransaksi(jenisid);
      if (res.status) {
        listtransaksi = res.data;
        hargaController.text = res.data[0].harga;
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> uploadbukti(file) async {
    try {
      submit.value = true;
      var res = await _service.sumitbukti(
          notrans.value,
          namaController.text,
          emailController.text,
          DateFormat('y-MM-dd H:mm:ss').format(selectedDate),
          harga.value,
          bankController.text,
          norekController.text,
          pesanController.text,
          file);
      if (res.status) {
        Get.back();
        Get.snackbar('Info', res.message,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Info',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      } else {
        Get.back();
        Get.snackbar('Info', res.message,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Info',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      }

      submit.value = false;
    } catch (e) {
      submit.value = false;
    }
  }
}
