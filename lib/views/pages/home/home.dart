import 'package:anggota/service/constants.dart';
import 'package:anggota/views/pages/dashboard/dashboard_controller.dart';
import 'package:anggota/views/pages/dashboard/menu.dart';
import 'package:anggota/views/widgets/custom_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/icons/logo.png',
                    height: 30,
                  ),
                ),
              ),
            ),
            title: const Text(
              'PERMATA GBKP KU',
              style: TextStyle(
                  // color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    dashboardController.logOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            ],
          ),
          body: ListView(
            children: [
              Obx(
                () => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '$juahjuah ' +
                          dashboardController.name.value.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Obx(() => (dashboardController.loading.value)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomSliderWidget(
                      items: dashboardController.imageslide.toList())),
              const SizedBox(
                height: 12.0,
              ),
              const MenuScreen()
            ],
          ));
    });
  }
}
