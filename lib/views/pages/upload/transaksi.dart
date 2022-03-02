import 'package:anggota/views/components/formatter.dart';
import 'package:anggota/views/pages/upload/upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTransaksiPage extends StatefulWidget {
  const ListTransaksiPage({Key? key}) : super(key: key);

  @override
  _ListTransaksiPageState createState() => _ListTransaksiPageState();
}

class _ListTransaksiPageState extends State<ListTransaksiPage> {
  final UploadController uploadController = Get.put(UploadController());

  @override
  void initState() {
    super.initState();
    uploadController.getListTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('transaksi'),
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
                          'Transaksi Pembelian Buku',
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
                      'List Transaksi Pembelian Buku',
                      style: TextStyle(color: Color(0xFF626B79)),
                    ),
                  ),
                  Expanded(
                    child: Obx(() => (uploadController.loading.value)
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
                              itemCount: uploadController.listtransaksi.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    uploadController.notrans.value =
                                        uploadController
                                            .listtransaksi[i].notrans;
                                    uploadController.jenis.value =
                                        '${uploadController.listtransaksi[i].jenis} Tahun ${uploadController.listtransaksi[i].tahun}';
                                    uploadController.harga.value = int.parse(
                                        uploadController
                                            .listtransaksi[i].harga);
                                    uploadController.rek.value =
                                        '${uploadController.listtransaksi[i].metode} No. Rek/Virtual Account ${uploadController.listtransaksi[i].rek}';
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ListTile(
                                      title: Text(uploadController
                                          .listtransaksi[i].notrans),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Jenis : ${uploadController.listtransaksi[i].jenis} Tahun ${uploadController.listtransaksi[i].tahun}'),
                                          Text(
                                              'Harga : Rp. ${Formatter.number(double.parse(uploadController.listtransaksi[i].harga))}')
                                        ],
                                      ),
                                      trailing: (uploadController
                                                  .listtransaksi[i].notrans ==
                                              uploadController.notrans.value)
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
