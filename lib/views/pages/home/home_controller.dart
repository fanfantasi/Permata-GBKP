import 'package:anggota/models/keanggotaan.dart';
import 'package:anggota/models/models.dart';
import 'package:anggota/service/constants.dart';
import 'package:anggota/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  RxBool editing = false.obs;
  RxBool updated = false.obs;
  RxBool editloading = false.obs;
  RxBool loadkeanggotaan = false.obs;
  final _service = Service();
  //
  final ktpController = TextEditingController();
  final namaController = TextEditingController();
  RxString gender = 'L'.obs;
  RxString sttsAnggota = '0'.obs;
  RxString status = '0'.obs;
  RxString photo = ''.obs;
  RxBool emptyphoto = false.obs;
  RxString pekerjaan = ''.obs;
  RxString pekerjaanid = ''.obs;
  RxString pendidikan = ''.obs;
  RxString pendidikanid = ''.obs;

  final kelaminController = TextEditingController();
  final tmplahirController = TextEditingController();
  final tgllahirController = TextEditingController();
  final telpController = TextEditingController();
  final emailController = TextEditingController();
  final klasisidController = TextEditingController();
  final runggunidController = TextEditingController();
  final perpulungenidController = TextEditingController();
  final sttsanggotaController = TextEditingController();
  final statusController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final pendidikanController = TextEditingController();
  final jurusanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getKeanggota();
  }

  Future<void> logOut() async {
    Future.delayed(Duration.zero, () async {
      Get.find<GetStorage>().remove('user');
      await Get.offAllNamed("/");
    });
  }

  List<DataAnggota> anggota = [];
  List<Verif> verif = [];
  Future<void> getAnggota() async {
    try {
      loading.value = true;
      anggota.clear();
      final result = await _service.getAnggota(jenisid);
      if (result.status) {
        anggota = result.data;
        verif = result.verif;
        loading.value = false;
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
    }
  }

  List<DataKeanggotaan> keanggotaan = [];
  Future<void> getKeanggota() async {
    try {
      loadkeanggotaan.value = true;
      keanggotaan.clear();
      final result = await _service.getKeanggota(jenisid);
      if (result.status) {
        keanggotaan = result.data;
        editing.value = keanggotaan[0].edit;
        ktpController.text = '**************';
        namaController.text = keanggotaan[0].fullName;
        gender.value = keanggotaan[0].gender;
        sttsAnggota.value = keanggotaan[0].sttsAnggota;
        status.value = keanggotaan[0].status;
        kelaminController.text = keanggotaan[0].gender;
        tmplahirController.text = keanggotaan[0].tmpLahir;
        tgllahirController.text = DateFormat('d MMM y')
            .format(DateTime.parse(keanggotaan[0].tglLahir));
        telpController.text = keanggotaan[0].noTelp;
        emailController.text = keanggotaan[0].email;
        klasisidController.text = keanggotaan[0].klasis!.klasis;
        runggunidController.text = keanggotaan[0].runggun!.runggun;
        perpulungenidController.text =
            keanggotaan[0].perpulungen?.perpulungen ?? '--';
        sttsanggotaController.text = keanggotaan[0].sttsAnggota;
        statusController.text = keanggotaan[0].status;
        pekerjaan.value = keanggotaan[0].idPekerjaan!.nmpekerjaan;
        pekerjaanid.value = keanggotaan[0].idPekerjaan!.id;
        pendidikan.value = keanggotaan[0].pendidikanId!.pendidikan;
        pendidikanid.value = keanggotaan[0].pendidikanId!.id;
        jurusanController.text = keanggotaan[0].jurusan;
        if (keanggotaan[0].photo != '') {
          photo.value = keanggotaan[0].photo;
          avatar = keanggotaan[0].photo;
          emptyphoto.value = false;
        } else {
          emptyphoto.value = true;
        }
        loadkeanggotaan.value = false;
      } else {
        loadkeanggotaan.value = false;
      }
    } catch (e) {
      loadkeanggotaan.value = false;
    }
  }

  List<DataPekerjaan> listpekerjaan = [];
  Future<void> getPekerjaan() async {
    try {
      loading.value = true;
      listpekerjaan.clear();
      final result = await _service.getpekerjaan();
      if (result.status) {
        listpekerjaan = result.data;
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  List<DataPendidikan> listpendidikan = [];
  Future<void> getPendidikan() async {
    try {
      loading.value = true;
      listpendidikan.clear();
      final result = await _service.getpendidikan();
      if (result.status) {
        listpendidikan = result.data;
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> updateAnggota(file) async {
    try {
      updated.value = true;
      final result = await _service.postanggota(
          keanggotaan[0].id,
          telpController.text,
          emailController.text,
          sttsAnggota.value,
          status.value,
          pekerjaanid.value,
          pendidikanid.value,
          jurusanController.text,
          file);
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
      } else {
        Get.snackbar('Error', result.message,
            colorText: Colors.white,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      }
      updated.value = false;
    } catch (e) {
      updated.value = false;
    }
  }
}
