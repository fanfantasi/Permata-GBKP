import 'package:anggota/views/pages/pembayaran/pembayaran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MetodePage extends StatefulWidget {
  const MetodePage({Key? key}) : super(key: key);

  @override
  _MetodePageState createState() => _MetodePageState();
}

class _MetodePageState extends State<MetodePage> {
  final PembayaranController pembayaranController =
      Get.put(PembayaranController());

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('metode'),
      direction: DismissDirection.vertical,
      onDismissed: (direction) {
        Get.back();
      },
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    )),
              ),
            ),
            Expanded(
              child: Material(
                  child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    height: 40,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.close)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          'Metode Pembayaran',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15.0),
                    height: 36.0,
                    child: const Text(
                      'Pilih Metode Pembayaran',
                      style: TextStyle(color: Color(0xFF626B79)),
                    ),
                  ),
                  Expanded(
                    child: Obx(() => (pembayaranController.loading.value)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            color: Colors.white,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, i) {
                                return const Divider(
                                  height: 1,
                                );
                              },
                              itemCount:
                                  pembayaranController.listrekening.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    pembayaranController.metodeid.value =
                                        pembayaranController.listrekening[i].id;
                                    pembayaranController.perusahaan.value =
                                        pembayaranController
                                            .listrekening[i].nama;
                                    pembayaranController.rek.value =
                                        pembayaranController
                                            .listrekening[i].rek;
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ListTile(
                                      title: Text(pembayaranController
                                          .listrekening[i].nama),
                                      trailing: (pembayaranController
                                                  .listrekening[i].nama ==
                                              pembayaranController
                                                  .perusahaan.value)
                                          ? const Icon(Icons.check)
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ))),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
