import 'package:anggota/models/bukupa.dart';
import 'package:anggota/service/constants.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BukupaController extends GetxController {
  RxBool loading = false.obs;
  final _service = Service();

  List<DataBukuPA> listbukupa = [];
  Future<bool> getbukupa(tahun) async {
    try {
      loading.value = true;
      var res = await _service.getbukupa(jenisid, tahun);
      if (res.status) {
        listbukupa = res.data;
        loading.value = false;
        return true;
      } else {
        if (res.conditional == 2) {
          Get.toNamed('/pembayaran', arguments: ['PA', tahun, res.message, 1]);
        } else if (res.conditional == 3) {
          Get.snackbar('Error',
              'Silahkan upload bukti pembayaran anda, atau hubungi kami',
              colorText: Colors.black87,
              backgroundColor: Colors.white.withOpacity(.9),
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              titleText: const Text(
                'Error',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ));
        } else if (res.conditional == 4) {
          Get.snackbar('Error', 'Pembayaran anda lagi dalam proses verifikasi',
              colorText: Colors.black87,
              backgroundColor: Colors.white.withOpacity(.9),
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              titleText: const Text(
                'Error',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ));
        } else if (res.conditional == 1) {
          Get.snackbar('Error', 'Mohon maaf, Buku masih dalam proses upload.',
              colorText: Colors.black87,
              backgroundColor: Colors.white.withOpacity(.9),
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              titleText: const Text(
                'Error',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ));
        } else {
          Get.toNamed('/pemesanan', arguments: ['PA', tahun]);
        }

        loading.value = false;
        return false;
      }
    } catch (e) {
      loading.value = false;
      return false;
    }
  }
}
