import 'package:anggota/service/services.dart';
import 'package:anggota/views/pages/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';

class ProfileController extends GetxController {
  RxString version = ''.obs;
  RxString buildNumber = ''.obs;
  RxBool submitpassword = false.obs;
  RxBool submit = false.obs;
  final _service = Service();
  final DashboardController dashboardController =
      Get.put(DashboardController());

  final oldpasswordController = TextEditingController();
  final passwordController = TextEditingController();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final telpController = TextEditingController();
  RxString photo = ''.obs;
  RxString uid = ''.obs;
  RxBool emptyphoto = false.obs;

  @override
  void onInit() {
    super.onInit();
    getVersion();
  }

  Future<void> getProfile() async {
    await GetStorage.init();
    final box = Get.find<GetStorage>();
    final session = box.read('user');
    namaController.text = session[0]['full_name'];
    emailController.text = session[0]['email'];
    uid.value = session[0]['id'];
    if (session[0]['photo'] != '') {
      photo.value = session[0]['photo'];
      emptyphoto.value = false;
    } else {
      emptyphoto.value = true;
    }
  }

  void getVersion() async {
    final PackageInfo _info = await PackageInfo.fromPlatform();
    version.value = _info.version;
    buildNumber.value = _info.buildNumber;
  }

  Future<void> clear() async {
    oldpasswordController.clear();
    passwordController.clear();
  }

  Future<void> changepassword() async {
    try {
      submitpassword.value = true;
      if (oldpasswordController.text == '' || passwordController.text == '') {
        Get.snackbar('Error', 'Harus diisi',
            colorText: Colors.white,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      } else {
        var res = await _service.changepassword(
            Get.arguments, oldpasswordController.text, passwordController.text);
        if (res.status) {
          Get.back();
          Get.snackbar('Success', res.message,
              colorText: Colors.white,
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              titleText: const Text(
                'Success',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ));
        } else {
          Get.snackbar('Error', res.message,
              colorText: Colors.white,
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              titleText: const Text(
                'Error',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ));
        }
      }
      submitpassword.value = false;
    } catch (e) {
      submitpassword.value = false;
    }
  }

  Future<void> updateProfile(file) async {
    try {
      submit.value = true;
      var res = await _service.sumitprofile(
          uid.value, emailController.text, telpController.text, file);
      if (res.status) {
        await GetStorage.init();
        final box = Get.find<GetStorage>();
        // await box.remove('photo');
        // await box.remove('email');
        await box.write('photo', res.data[0].photo);
        await box.write('email', res.data[0].email);
        dashboardController.email.value = res.data[0].email;
        dashboardController.photo.value = res.data[0].photo;
        Get.back();
        Get.snackbar('Success', res.message,
            colorText: Colors.white,
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Success',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ));
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

  Future<void> logOut() async {
    Future.delayed(Duration.zero, () async {
      Get.find<GetStorage>().remove('user');
      await Get.offAllNamed("/");
    });
  }
}
