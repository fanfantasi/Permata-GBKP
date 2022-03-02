import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabController extends GetxController with SingleGetTickerProviderMixin {
  List<Tab> myTabs = <Tab>[
    const Tab(text: 'loading...'),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
    asyncLoadTabs();
  }

  void asyncLoadTabs({int index = 0}) async {
    await Future.delayed(Duration.zero, () {
      myTabs = [
        const Tab(text: 'Data Anggota'),
        const Tab(text: 'Edit Data'),
        const Tab(text: 'Verifikasi'),
        const Tab(text: 'Pindah'),
        const Tab(text: 'Hapus'),
      ];
      controller.dispose();
      controller = TabController(
          vsync: this, length: myTabs.length, initialIndex: index);
      update();
    });
  }

  void switchTab(int index) async {
    asyncLoadTabs(index: index);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
