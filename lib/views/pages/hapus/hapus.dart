import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/date_format.dart';
import 'package:anggota/views/pages/hapus/hapus_controller.dart';
import 'package:anggota/views/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HapusPage extends StatefulWidget {
  const HapusPage({Key? key}) : super(key: key);

  @override
  State<HapusPage> createState() => _HapusPageState();
}

class _HapusPageState extends State<HapusPage> {
  final HomeController homeController = Get.put(HomeController());
  final HapusController hapusController = Get.put(HapusController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Obx(() => (homeController.editing.value)
          ? (hapusController.loading.value)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (hapusController.listhapus.isNotEmpty)
                  ? ListView.builder(
                      itemCount: hapusController.listhapus.length,
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
                                    Text(hapusController.listhapus[i].status)
                                  ],
                                )),
                                Text(
                                  TimeAgo.timeAgoSinceDate(
                                      hapusController.listhapus[i].waktu),
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
                                hapusController.listhapus[i].remarks,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Validasi : ${hapusController.listhapus[i].validasi}',
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
                      })
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
