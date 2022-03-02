import 'package:anggota/views/pages/pembayaran/pembayaran_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KonfirmasiPage extends StatefulWidget {
  const KonfirmasiPage({Key? key}) : super(key: key);

  @override
  State<KonfirmasiPage> createState() => _KonfirmasiPageState();
}

class _KonfirmasiPageState extends State<KonfirmasiPage> {
  final PembayaranController pembayaranController =
      Get.put(PembayaranController());
  @override
  void initState() {
    super.initState();
    pembayaranController.getconfirmasi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Konfirmasi Pembayaran'),
        ),
        body: Obx(
          () => (pembayaranController.loading.value)
              ? const Center(child: CircularProgressIndicator())
              : Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Terima Kasih.',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          pembayaranController.dataPesan.pesan,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
