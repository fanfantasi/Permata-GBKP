import 'package:anggota/service/constants.dart';
import 'package:anggota/views/pages/dashboard/dashboard_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  @override
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: 1.0,
      padding: const EdgeInsets.all(12.0),
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 18.0,
      crossAxisCount: 3,
      children: [
        MenuBtn(
          imgpath: 'assets/icons/member-card.png',
          text: "Keanggotaan",
          press: () {
            Get.toNamed('/tabanggota');
          },
        ),
        MenuBtn(
          imgpath: 'assets/icons/open-book.png',
          text: "Buku PA",
          press: () {
            Get.toNamed('/bukupa');
          },
        ),
        MenuBtn(
          imgpath: 'assets/icons/file.png',
          text: "P3RT",
          press: () async {
            bool data = await dashboardController.getbukup3rt();
            if (data) {
              Get.toNamed('/viewpdf', arguments: [
                dashboardController.listbukup3rt[0],
                dashboardController.listbukup3rt[0].file
              ]);
            }
          },
        ),
        MenuBtn(
          imgpath: 'assets/icons/calendar.png',
          text: "Event",
          press: () {
            Get.snackbar('Info', 'Feature Unavailable',
                colorText: Colors.black87,
                barBlur: .1,
                backgroundColor: Colors.white.withOpacity(.9),
                snackStyle: SnackStyle.FLOATING,
                margin: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                titleText: const Text(
                  'Info',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ));
          },
        ),
        MenuBtn(
          imgpath: 'assets/icons/preview.png',
          text: "Cari Runggun",
          press: () {
            Get.snackbar('Info', 'Feature Unavailable',
                colorText: Colors.black87,
                barBlur: .1,
                backgroundColor: Colors.white.withOpacity(.9),
                snackStyle: SnackStyle.FLOATING,
                margin: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                titleText: const Text(
                  'Info',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ));
          },
        ),
        MenuBtn(
          imgpath: 'assets/icons/cloud-computing.png',
          text: "Konfirmasi Pembayaran",
          press: () {
            Get.toNamed('/upload');
          },
        ),
      ],
    );
  }
}

class MenuBtn extends StatelessWidget {
  final String? imgpath;
  final String? text;
  final Function? press;
  const MenuBtn({
    Key? key,
    this.imgpath,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press!();
      },
      child: Container(
          width: 69,
          height: 69,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            border: Border.all(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '$imgpath',
                color: Colors.white,
                width: 52,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
