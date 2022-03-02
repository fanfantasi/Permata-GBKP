import 'package:anggota/views/components/formatter.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/pages/home/home_controller.dart';
import 'package:anggota/views/pages/pemesanan/pemesanan_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class PemesananPage extends StatefulWidget {
  const PemesananPage({Key? key}) : super(key: key);

  @override
  _PemesananPageState createState() => _PemesananPageState();
}

class _PemesananPageState extends State<PemesananPage> {
  final HomeController homeController = Get.put(HomeController());
  final PemesananController pemesananController =
      Get.put(PemesananController());

  @override
  void initState() {
    super.initState();
    homeController.getAnggota();
    pemesananController.gettahun(Get.arguments[1]);
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
                            Obx(() => (pemesananController.loading.value)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: (pemesananController.status.value)
                                        ? Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Anda Akan membeli buku ${Get.arguments[0]} Tahun ${pemesananController.datatahun!.tahun}\nHarga Buku Rp. ${Formatter.number(double.parse(pemesananController.datatahun!.harga))}',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 24.0,
                                              ),
                                              Obx(
                                                () => (pemesananController
                                                        .submit.value)
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : RoundedButton(
                                                        text:
                                                            "Lanjut Pemesanan",
                                                        press: () {
                                                          pemesananController.postpemesanan(
                                                              1,
                                                              pemesananController
                                                                  .datatahun!
                                                                  .id,
                                                              pemesananController
                                                                  .datatahun!
                                                                  .harga);
                                                        },
                                                      ),
                                              )
                                            ],
                                          )
                                        : const Center(
                                            child: Text(
                                                'Mohon Maaf Buku PA Belum Tersedia'),
                                          ),
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
