import 'dart:async';

import 'package:anggota/models/models.dart';
import 'package:anggota/service/constants.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  final _service = Service();
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString photo = ''.obs;
  RxString uid = ''.obs;
  RxBool loading = false.obs;
  RxBool pdf = false.obs;
  var tabIndex = 0;
  var timer = 0;

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getSlider();
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  Future<bool> onWillPop() async {
    if (tabIndex != 0) {
      changeTabIndex(0);
      timer = 0;
    } else {
      timer = timer + 1;
      if (timer < 2) {
        Fluttertoast.showToast(
            msg: "Tap sekali lagi untuk keluar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue.withOpacity(.4),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        return true;
      }
    }
    // ignore: null_check_always_fails
    return null!;
  }

  Future<void> getProfile() async {
    await GetStorage.init();
    final box = Get.find<GetStorage>();
    final session = box.read('user');
    photo.value = box.read('photo');
    email.value = box.read('email');
    name.value = box.read('fullname');
    uid.value = session[0]['id'];
    photo.value = session[0]['photo'];
    jenisid = session[0]['jenisid'];
    islevel = session[0]['islevel'];
    isjenis = session[0]['isjenis'];
  }

  List<DataSlider> listslider = [];
  List imageslide = [];
  Future<void> getSlider() async {
    try {
      loading.value = true;
      listslider.clear();
      final result = await _service.getslider();
      if (result.status) {
        listslider = result.data;
        for (var i = 0; i < listslider.length; i++) {
          imageslide.add(listslider[i].file);
        }
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  List<DataPtigart> listbukup3rt = [];
  Future<bool> getbukup3rt() async {
    try {
      pdf.value = true;
      var res = await _service.getbukup3rt(jenisid);
      if (res.status) {
        listbukup3rt = res.data;
        if (res.data[0].status != '1' && res.data[0].metode == '') {
          Get.toNamed('/pembayaran', arguments: ['P3RT', listbukup3rt[0], 2]);
          return false;
        } else if (res.data[0].status != '1' && res.data[0].metode != '') {
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
          return false;
        } else {
          pdf.value = false;
          return true;
        }
      } else {
        if (res.data.isNotEmpty) {
          listbukup3rt = res.data;
          Get.toNamed('/pemesananp3rt',
              arguments: ['P3RT', listbukup3rt[0], 2]);
          pdf.value = false;
          return false;
        } else {
          Get.snackbar('Error', 'Mohon maaf, buku P3RT Belum tersedia.',
              colorText: Colors.black87,
              backgroundColor: Colors.white.withOpacity(.9),
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              titleText: const Text(
                'Error',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ));
          pdf.value = false;
          return false;
        }
      }
    } catch (e) {
      pdf.value = false;
      return false;
    }
  }

  Future<void> logOut() async {
    Future.delayed(Duration.zero, () async {
      Get.find<GetStorage>().remove('user');
      await Get.offAllNamed("/");
    });
  }
}
