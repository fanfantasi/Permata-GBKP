import 'package:anggota/service/constants.dart';
import 'package:anggota/views/pages/home/widget/personlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class VerifikasiScreen extends StatefulWidget {
  const VerifikasiScreen({Key? key}) : super(key: key);

  @override
  State<VerifikasiScreen> createState() => _VerifikasiScreenState();
}

class _VerifikasiScreenState extends State<VerifikasiScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Obx(() => (homeController.loading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: const Text(
                        'Tahapan Verifikasi',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      )),
                  const SizedBox(height: 18),
                  verif(homeController.verif[0].approveRunggun, 'Runggun'),
                  verif(homeController.verif[0].approveKlasis, 'Klasis'),
                  verif(homeController.verif[0].approveAdmin, 'Admin Pusat'),
                ],
              )),
      ),
    );
  }

  Widget verif(int status, text) {
    switch (status) {
      case 1:
        return PersonWidget(
          icon: Icons.info_outline,
          label: text,
          text: 'Verifikasi Oleh $text Dalam Proses',
        );
      case 2:
        return PersonWidget(
          icon: Icons.highlight_off,
          label: text,
          text: 'Verifikasi Oleh $text Ditolak',
        );

      default:
        return PersonWidget(
          icon: Icons.task_alt,
          label: text,
          text: 'Verifikasi Oleh $text Diterima',
        );
    }
  }
}
