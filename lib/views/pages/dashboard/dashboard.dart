import 'package:anggota/service/constants.dart';
import 'package:anggota/views/pages/dashboard/dashboard_controller.dart';
import 'package:anggota/views/pages/home/home.dart';
import 'package:anggota/views/pages/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return WillPopScope(
            key: key,
            onWillPop: controller.onWillPop,
            child: Scaffold(
              body: Container(
                  color: kPrimaryBgColor,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      IndexedStack(
                        index: controller.tabIndex,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const HomePage(),
                          const ProfilePage(),
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                        ),
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(75),
                              topRight: Radius.circular(75),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                          child: BottomNavigationBar(
                            backgroundColor: kPrimaryColor,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            onTap: controller.changeTabIndex,
                            currentIndex: controller.tabIndex,
                            items: [
                              BottomNavigationBarItem(
                                icon: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Icon(
                                      Icons.home,
                                      size: 32,
                                      color: controller.tabIndex == 0
                                          ? Colors.white
                                          : const Color(0xFFfafafa),
                                    )),
                                label: 'Home',
                              ),
                              BottomNavigationBarItem(
                                  icon: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Icon(
                                        Icons.person,
                                        size: 32,
                                        color: controller.tabIndex == 1
                                            ? Colors.white
                                            : const Color(0xFFfafafa),
                                      )),
                                  label: 'Profile'),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ));
      },
    );
  }
}
