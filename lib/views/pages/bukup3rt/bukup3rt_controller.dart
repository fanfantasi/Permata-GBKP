import 'dart:math';

import 'package:anggota/service/constants.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BukuP3RTController extends GetxController {
  RxBool loading = false.obs;
  RxBool status = false.obs;
  RxBool submit = false.obs;
  final _service = Service();

  Future<void> postpemesanan(jenis, id, harga, tahun) async {
    try {
      submit.value = true;
      var rng = Random();
      var res = await _service.getpemesanan(
          DateFormat('y-MM-dd').format(DateTime.now()),
          jenisid,
          jenis,
          id,
          int.parse(harga) + rng.nextInt(100));
      if (res.status) {
        Get.toNamed('/pembayaran', arguments: ['P3RT', tahun, res.data, 2]);
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
