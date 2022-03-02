import 'package:anggota/views/components/formatter.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/pages/bukup3rt/bukup3rt_controller.dart';
import 'package:anggota/views/pages/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class PemesananP3RTPage extends StatefulWidget {
  const PemesananP3RTPage({Key? key}) : super(key: key);

  @override
  _PemesananP3RTPageState createState() => _PemesananP3RTPageState();
}

class _PemesananP3RTPageState extends State<PemesananP3RTPage> {
  final HomeController homeController = Get.put(HomeController());
  final BukuP3RTController bukuP3RTController = Get.put(BukuP3RTController());

  @override
  void initState() {
    super.initState();
    homeController.getAnggota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemesanan Buku'),
      ),
      body: Obx(
        () => (homeController.loading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    Center(
                        child: Text(
                      'Pemesanan Buku ${Get.arguments == null ? '--' : Get.arguments[0]}',
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Card(
                      elevation: 1.0,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Text('Klasis')),
                                Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Text(':')),
                                Text(
                                  homeController.anggota[0].klasis!.klasis
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Text('Runggun')),
                                Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Text(':')),
                                Text(
                                  homeController.anggota[0].runggun!.runggun
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Text('Nama Lengkap')),
                                Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Text(':')),
                                Text(
                                  homeController.anggota[0].nama.toString(),
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Text('Email')),
                                Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Text(':')),
                                Text(
                                  homeController.anggota[0].email.toString(),
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 44.0,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(right: 12.0),
                                child: const Center(
                                  child: Text(
                                    'PERHATIAN !!!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Anda Akan membeli buku ${Get.arguments[0]} Tahun ${Get.arguments[1].tahun}\nHarga Buku Rp. ${Formatter.number(double.parse(Get.arguments[1].harga))}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24.0,
                                    ),
                                    Obx(
                                      () => (bukuP3RTController.submit.value)
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : RoundedButton(
                                              text: "Lanjut Pemesanan",
                                              press: () {
                                                bukuP3RTController
                                                    .postpemesanan(
                                                        2,
                                                        Get.arguments[1].id,
                                                        Get.arguments[1].harga,
                                                        Get.arguments[1].tahun);
                                              },
                                            ),
                                    )
                                  ],
                                )),
                            const SizedBox(
                              height: 24.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
