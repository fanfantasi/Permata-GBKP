import 'package:anggota/views/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashscreenController splashController = Get.put(SplashscreenController());

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(child: Image.asset('assets/icons/logo.png')),
          ),
          Obx(
            () => Visibility(
              visible: splashController.version.value != '' &&
                  splashController.buildNumber.value != '',
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'PERMATA GBKP v.' + splashController.version.value,
                  style: const TextStyle(color: Colors.grey, fontSize: 10.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
