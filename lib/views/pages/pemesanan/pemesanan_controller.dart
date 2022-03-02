import 'dart:math';

import 'package:anggota/models/models.dart';
import 'package:anggota/service/constants.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PemesananController extends GetxController {
  RxBool loading = false.obs;
  RxBool status = false.obs;
  RxBool submit = false.obs;
  final _service = Service();

  DataTahun? datatahun;
  Future<void> gettahun(tahun) async {
    try {
      loading.value = true;
      var res = await _service.gettahun(tahun);
      if (res.status) {
        status.value = true;
        datatahun = res.data[0];
      } else {
        status.value = false;
        Get.snackbar('Error', 'Mohon Maaf Buku belum tersedia',
            colorText: Colors.white,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> postpemesanan(jenis, tahunid, harga) async {
    try {
      submit.value = true;
      var rng = Random();
      var res = await _service.getpemesanan(
          DateFormat('y-MM-dd').format(DateTime.now()),
          jenisid,
          jenis,
          tahunid,
          int.parse(harga) + rng.nextInt(100));
      if (res.status) {
        if (jenis == 1) {
          Get.toNamed('/pembayaran',
              arguments: ['PA', datatahun!.tahun, res.data, 1]);
        } else {
          Get.toNamed('/pembayaran', arguments: ['P3RT', tahunid, res.data, 1]);
        }
      } else {
        Get.snackbar('Error', res.message,
            colorText: Colors.white,
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
