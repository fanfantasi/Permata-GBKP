import 'package:anggota/views/pages/hapus/hapus.dart';
import 'package:anggota/views/pages/hapus/hapus_controller.dart';
import 'package:anggota/views/pages/home/edit.dart';
import 'package:anggota/views/pages/home/home_controller.dart';
import 'package:anggota/views/pages/home/informasi.dart';
import 'package:anggota/views/pages/home/verifikasi.dart';
import 'package:anggota/views/pages/pindah/pindah.dart';
import 'package:anggota/views/pages/pindah/pindah_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabKeanggotaan extends StatefulWidget {
  const TabKeanggotaan({Key? key}) : super(key: key);

  @override
  _TabKeanggotaanState createState() => _TabKeanggotaanState();
}

class _TabKeanggotaanState extends State<TabKeanggotaan>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final HomeController homeController = Get.put(HomeController());
  final PindahController pindahController = Get.put(PindahController());
  final HapusController hapusController = Get.put(HapusController());
  int idx = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
  }

  void switchTab(int index) async {
    switch (index) {
      case 1:
        setState(() {
          idx = index;
        });
        // homeController.getKeanggota();
        homeController.getPekerjaan();
        homeController.getPendidikan();
        break;
      case 2:
        setState(() {
          idx = index;
        });
        homeController.getAnggota();
        break;

      case 3:
        setState(() {
          idx = index;
        });
        pindahController.getPindah();
        break;
      case 4:
        setState(() {
          idx = index;
        });
        hapusController.getHapus();
        break;

      default:
        setState(() {
          idx = index;
        });
        homeController.getKeanggota();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Keanggotaan'),
          actions: [
            Obx(() => (homeController.editing.value)
                ? Visibility(
                    visible: idx == 3,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/formpindah');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: const Center(
                            child: Text(
                          'Ajukan Pindah',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  )
                : Container()),
            Obx(() => (homeController.editing.value)
                ? Visibility(
                    visible: idx == 4,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/formhapus');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: const Center(
                            child: Text(
                          'Ajukan Hapus',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  )
                : Container())
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            isScrollable: false,
            unselectedLabelColor: Colors.white,
            controller: tabController,
            onTap: switchTab,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              const Tab(text: 'Data Anggota'),
              const Tab(text: 'Edit Data'),
              const Tab(text: 'Verifikasi'),
              const Tab(text: 'Pindah'),
              const Tab(text: 'Hapus'),
            ],
          ),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        body: TabBarView(controller: tabController, children: [
          const InformasiScreen(),
          const EditScreen(),
          const VerifikasiScreen(),
          const PindahPage(),
          const HapusPage(),
        ]),
      ),
    );
  }
}
