import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/date_format.dart';
import 'package:anggota/views/pages/home/home_controller.dart';
import 'package:anggota/views/pages/pindah/pindah_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PindahPage extends StatelessWidget {
  const PindahPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final PindahController pindahController = Get.put(PindahController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Obx(() => (homeController.editing.value)
          ? (pindahController.loading.value)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (pindahController.listpindah.isNotEmpty)
                  ? ListView.builder(
                      itemCount: pindahController.listpindah.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_box,
                                      color: kPrimaryColor,
                                    ),
                                    Text(pindahController.listpindah[i].status)
                                  ],
                                )),
                                Text(
                                  TimeAgo.timeAgoSinceDate(
                                      pindahController.listpindah[i].waktu),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                pindahController.listpindah[i].remarks,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Validasi : ${pindahController.listpindah[i].validasi}',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            const Divider(
                              height: 1,
                            )
                          ],
                        );
                      },
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/access.png'),
                          const Center(
                            child: Text(
                              'Data Masih Kosong.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/access.png'),
                  const Center(
                    child: Text(
                      'Data anda belum bisa di edit, karena validasi belum selesai dilakukan, silahkan cek lagi nanti.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            )),
    );
  }
}
