import 'package:anggota/views/components/date_format.dart';
import 'package:anggota/views/components/formatter.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/pages/pembayaran/metode.dart';
import 'package:anggota/views/pages/pembayaran/pembayaran_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({Key? key}) : super(key: key);

  @override
  _PembayaranPageState createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final PembayaranController pembayaranController =
      Get.put(PembayaranController());

  @override
  void initState() {
    super.initState();
    () {
      getData().then((value) {
        if (value) {
          pembayaranController.getrekening();
        }
      });
    }();
  }

  Future<bool> getData() async {
    return await pembayaranController.getpembelian(Get.arguments[3]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Metode Pembayaran'),
        ),
        body: Obx(
          () => (pembayaranController.loading.value)
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    children: [
                      const Center(
                          child: Text(
                        'Metode Pembayaran',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 12.0),
                                child: const Text('No. Transaksi')),
                            Container(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: const Text(':')),
                            Text(
                              pembayaranController.listpembelian![0].notrans,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0.0),
                        color: Colors.white,
                        child: ListTile(
                          title: const Text('Nama Lengkap'),
                          subtitle: Text(
                              '${pembayaranController.listpembelian![0].fullName} '),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        indent: 16.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0.0),
                        color: Colors.white,
                        child: ListTile(
                          title: const Text('Jenis Buku'),
                          subtitle: Text(
                              'Buku ${Get.arguments[0]} ${Get.arguments[1]} '),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        indent: 16.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0.0),
                        color: Colors.white,
                        child: ListTile(
                          title: const Text('Tanggal Pembelian'),
                          subtitle: Text(
                              '${TimeAgo.timeAgoSinceDate(pembayaranController.listpembelian![0].tglBeli)} '),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        indent: 16.0,
                      ),
                      Obx(
                        () => Container(
                          margin: const EdgeInsets.only(top: 0.0),
                          color: Colors.white,
                          child: ListTile(
                              title: const Text('Metode Pembayaran'),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Color(0xFF4B61DD),
                              ),
                              onTap: () async {
                                await Get.generalDialog(
                                  routeSettings: RouteSettings(
                                      name: '/metode',
                                      arguments: Get.arguments),
                                  barrierLabel: "metode",
                                  barrierDismissible: false,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  transitionDuration:
                                      const Duration(milliseconds: 100),
                                  pageBuilder: (context, anim1, anim2) {
                                    return const MetodePage();
                                  },
                                  transitionBuilder:
                                      (context, anim1, anim2, child) {
                                    return SlideTransition(
                                      position: Tween(
                                              begin: const Offset(0, 1),
                                              end: const Offset(0, 0))
                                          .animate(anim1),
                                      child: child,
                                    );
                                  },
                                );
                              },
                              subtitle:
                                  pembayaranController.perusahaan.value == ''
                                      ? const Text('Belum Ditentukan')
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(pembayaranController
                                                .perusahaan.value),
                                            Text(
                                              pembayaranController.rek.value,
                                              style: const TextStyle(
                                                  color: Colors.green),
                                            )
                                          ],
                                        )),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        indent: 16.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0.0),
                        color: Colors.white,
                        child: ListTile(
                            title: const Text('Total Pembayaran'),
                            subtitle: Text(
                              'Rp. ${Formatter.number(
                                double.parse(pembayaranController
                                    .listpembelian![0].harga),
                              )}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                      const Divider(
                        height: 1,
                        indent: 16.0,
                      ),
                      Obx(
                        () => (pembayaranController.submit.value)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : RoundedButton(
                                text: "Bayar",
                                press: () {
                                  if (pembayaranController.rek.value == '') {
                                    Get.snackbar('Error',
                                        'Silahkan tentukan metode pembayaran anda.',
                                        colorText: Colors.black87,
                                        backgroundColor:
                                            Colors.white.withOpacity(.9),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 12.0),
                                        titleText: const Text(
                                          'Error',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ));
                                  } else {
                                    pembayaranController.getpembayaran();
                                  }
                                },
                              ),
                      )
                    ],
                  ),
                ),
        ));
  }
}
