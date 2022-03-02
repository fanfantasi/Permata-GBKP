import 'package:anggota/service/constants.dart';
import 'package:anggota/views/pages/bukupa/bukupa_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TahunBukuPage extends StatefulWidget {
  const TahunBukuPage({Key? key}) : super(key: key);

  @override
  _TahunBukuPageState createState() => _TahunBukuPageState();
}

class _TahunBukuPageState extends State<TahunBukuPage> {
  final BukupaController bukupaController = Get.put(BukupaController());

  @override
  void initState() {
    super.initState();
    // bukupaController.getbukupa(Get.parameters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buku PA ${Get.arguments}'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1,
            children: List.generate(bukupaController.listbukupa.length, (i) {
              return Card(
                child: GestureDetector(
                  onTap: () async {
                    Get.toNamed('/viewpdf', arguments: [
                      bukupaController.listbukupa[i],
                      bukupaController.listbukupa[i].file
                    ]);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kPrimaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              bukupaController.listbukupa[i].title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/icons/open-book.png',
                                color: Colors.white.withOpacity(0.7),
                                width: 25,
                                height: 24,
                              )),
                        ],
                      )),
                ),
              );
            })),
      ),
    );
  }
}
