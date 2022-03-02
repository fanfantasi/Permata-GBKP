import 'package:anggota/models/models.dart';
import 'package:anggota/models/pesan.dart';
import 'package:anggota/service/services.dart';
import 'package:get/get.dart';

class PembayaranController extends GetxController {
  RxBool loading = false.obs;
  RxBool submit = false.obs;
  RxString perusahaan = ''.obs;
  RxString rek = ''.obs;
  RxString metodeid = ''.obs;
  final _service = Service();

  List<DataRekening> listrekening = [];
  Future<void> getrekening() async {
    try {
      loading.value = true;
      var res = await _service.getrekening();
      if (res.status) {
        listrekening = res.data;
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  List<DataPembelian>? listpembelian = [];
  Future<bool> getpembelian(jenis) async {
    try {
      loading.value = true;
      var res = await _service.getpembalian(Get.arguments[2], jenis);
      if (res.status) {
        listpembelian = res.data;
        perusahaan.value = res.data[0].metode;
        rek.value = res.data[0].rek;
        loading.value = false;
        return true;
      } else {
        loading.value = false;
        return false;
      }
    } catch (e) {
      loading.value = false;
      return false;
    }
  }

  late TransaksiModel listtransaksi;
  Future<void> getpembayaran() async {
    try {
      submit.value = true;
      var res = await _service.getpembayaran(
          metodeid.value, listpembelian![0].notrans);
      if (res.status) {
        listtransaksi = res;
        Get.offNamedUntil('/confirmasi', (route) => route.isFirst);
      }
      submit.value = false;
    } catch (e) {
      submit.value = false;
    }
  }

  late DataPesan dataPesan;
  Future<void> getconfirmasi() async {
    try {
      loading.value = true;
      var res = await _service.getpesan();
      if (res.status) {
        dataPesan = res.data[0];
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }
}
