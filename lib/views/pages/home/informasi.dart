import 'package:anggota/service/constants.dart';
import 'package:anggota/views/pages/home/home_controller.dart';
import 'package:anggota/views/pages/home/widget/personlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InformasiScreen extends StatefulWidget {
  const InformasiScreen({Key? key}) : super(key: key);

  @override
  State<InformasiScreen> createState() => _InformasiScreenState();
}

class _InformasiScreenState extends State<InformasiScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Obx(() => (homeController.loadkeanggotaan.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: homeController.keanggotaan[0].photo,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 125,
                        height: 125.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(70.0)),
                          image: DecorationImage(image: imageProvider),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 125.0,
                        height: 125.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(70.0)),
                          image: const DecorationImage(
                              image: AssetImage(
                            'assets/icons/ic-bgactivity.png',
                          )),
                        ),
                      ),
                    ),
                  ),
                  PersonWidget(
                    icon: Icons.person,
                    label: 'Nama Lengkap',
                    text: homeController.keanggotaan[0].fullName,
                  ),
                  PersonWidget(
                    icon: Icons.phone_android,
                    label: 'No. Telp/HP',
                    text: homeController.keanggotaan[0].noTelp,
                  ),
                  PersonWidget(
                    icon: Icons.email,
                    label: 'Email',
                    text: homeController.keanggotaan[0].email,
                  ),
                  PersonWidget(
                    icon: Icons.location_on,
                    label: 'Tempat, Tgl Lahir',
                    text: homeController.keanggotaan[0].tmpLahir +
                        ', ' +
                        DateFormat('d MMM y').format(DateTime.parse(
                            homeController.keanggotaan[0].tglLahir)),
                  ),
                  PersonWidget(
                    icon: Icons.check_box_rounded,
                    label: 'Klasis',
                    text: homeController.keanggotaan[0].klasis!.klasis,
                  ),
                  PersonWidget(
                    icon: Icons.check_box_rounded,
                    label: 'Runggun',
                    text: homeController.keanggotaan[0].runggun!.runggun,
                  ),
                  PersonWidget(
                    icon: Icons.check_box_rounded,
                    label: 'Perpulungen',
                    text: (homeController.keanggotaan[0].perpulungen == null)
                        ? '-'
                        : homeController
                            .keanggotaan[0].perpulungen!.perpulungen,
                  ),
                  PersonWidget(
                      icon: Icons.verified,
                      label: 'Status Keanggotaan',
                      text: (int.parse(
                                  homeController.keanggotaan[0].sttsAnggota) ==
                              0)
                          ? 'Biasa'
                          : 'Luar Biasa'),
                  PersonWidget(
                      icon: Icons.task_alt,
                      label: 'Status',
                      text:
                          (int.parse(homeController.keanggotaan[0].status) == 0)
                              ? 'Tidak Aktif'
                              : 'Aktif'),
                ],
              )),
      ),
    );
  }
}
