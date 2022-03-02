import 'package:anggota/service/constants.dart';
import 'package:anggota/views/pages/bukupa/bukupa_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BukupaPage extends StatefulWidget {
  const BukupaPage({Key? key}) : super(key: key);

  @override
  BukupaPageState createState() => BukupaPageState();
}

class BukupaPageState extends State<BukupaPage> {
  final BukupaController bukupaController = Get.put(BukupaController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahun Buku PA'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(5, (index) {
              var tahun =
                  DateFormat('y').format(DateTime(DateTime.now().year - index));
              return InkWell(
                onTap: () async {
                  bool data = await bukupaController.getbukupa(tahun);
                  if (data) Get.toNamed('/tahunbuku', arguments: tahun);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      'Tahun $tahun',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: kPrimaryColor, fontSize: 50.0),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
