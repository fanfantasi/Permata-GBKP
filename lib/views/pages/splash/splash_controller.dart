import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';

class SplashscreenController extends GetxController {
  RxString version = ''.obs;
  RxString buildNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getVersion();
    startSplashScreen();
  }

  void getVersion() async {
    final PackageInfo _info = await PackageInfo.fromPlatform();
    version.value = _info.version;
    buildNumber.value = _info.buildNumber;
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 2);
    await GetStorage.init();
    final box = Get.find<GetStorage>();

    return Timer(duration, () async {
      final session = box.read('user');
      if (session == null) {
        Get.toNamed("/welcome");
      } else {
        // await box.write('user', response.data?.persistSessionString);
        Get.offAllNamed("/home");
      }
    });
  }

  void privacypolice() async {
    final box = Get.find<GetStorage>();
    await box.write('privacy', 'agree');
    await startSplashScreen();
  }
}
