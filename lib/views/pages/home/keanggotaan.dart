import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/pages/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeanggotaanScreen extends StatelessWidget {
  final HomeController homeController;
  final String? photo;
  final VoidCallback onTapModal;
  final Function onClose;
  final bool edited;
  const KeanggotaanScreen(
      {Key? key,
      required this.homeController,
      required this.photo,
      required this.edited,
      required this.onTapModal,
      required this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => (homeController.loadkeanggotaan.value)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : (homeController.keanggotaan[0].edit)
            ? ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: const Text(
                            'Data Keanggotaan',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          )),
                      IconButton(
                          onPressed: () {
                            Get.toNamed('/edit',
                                arguments: homeController.keanggotaan[0]);
                          },
                          icon: const Icon(
                            Icons.note_alt_outlined,
                            color: kPrimaryColor,
                          ))
                    ],
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: homeController.photo.value,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 125,
                        height: 125.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(70.0)),
                          image: DecorationImage(image: imageProvider),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 125.0,
                        height: 125.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 2.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(70.0)),
                          image: const DecorationImage(
                              image: AssetImage(
                            'assets/icons/ic-bgactivity.png',
                          )),
                        ),
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.ktpController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.verified_user,
                          color: kPrimaryColor,
                        ),
                        labelText: 'KTP',
                        hintText: 'KTP',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.namaController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Nama Lengkap',
                        hintText: 'Nama Lengkap',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text("Jenis Kelamin"),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => homeController.gender.value = "P",
                            child: Container(
                              height: 36,
                              width: 86,
                              decoration: BoxDecoration(
                                  color: homeController.gender.value == 'P'
                                      ? kPrimaryColor.withOpacity(0.5)
                                      : Colors.transparent,
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: const Center(child: Text('Wanita')),
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => homeController.gender.value = "L",
                            child: Container(
                              height: 36,
                              width: 86,
                              decoration: BoxDecoration(
                                  color: homeController.gender.value == 'L'
                                      ? kPrimaryColor.withOpacity(0.5)
                                      : Colors.transparent,
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: const Center(child: Text('Pria')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.tmplahirController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.location_on,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Tempat Lahir',
                        hintText: 'Tempat Lahir',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.tgllahirController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Tanggal Lahir',
                        hintText: 'Tanggal Lahir',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.telpController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.phone_android,
                          color: kPrimaryColor,
                        ),
                        labelText: 'No. Telp',
                        hintText: 'No. Telp',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.emailController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Email',
                        hintText: 'Email',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.klasisidController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.check_box,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Klasis',
                        hintText: 'Klasis',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.runggunidController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.check_box,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Runggun',
                        hintText: 'Runggun',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.perpulungenidController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.check_box,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Perpulungen',
                        hintText: 'Perpulungen',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text("Status Keanggotaan"),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => homeController.sttsAnggota.value = "0",
                            child: Container(
                                height: 36,
                                width: 86,
                                decoration: BoxDecoration(
                                    color:
                                        homeController.sttsAnggota.value == '0'
                                            ? kPrimaryColor.withOpacity(0.5)
                                            : Colors.transparent,
                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: const Center(child: Text('Biasa'))),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => homeController.sttsAnggota.value = "1",
                            child: Container(
                                height: 36,
                                width: 86,
                                decoration: BoxDecoration(
                                    color:
                                        homeController.sttsAnggota.value == '1'
                                            ? kPrimaryColor.withOpacity(0.5)
                                            : Colors.transparent,
                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: const Center(child: Text('Luar Biasa'))),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0, top: 12.0),
                        child: Text("Status"),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => homeController.status.value = "0",
                            child: Container(
                                height: 36,
                                width: 86,
                                decoration: BoxDecoration(
                                    color: homeController.status.value == '0'
                                        ? kPrimaryColor.withOpacity(0.5)
                                        : Colors.transparent,
                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child:
                                    const Center(child: Text('Tidak Aktif'))),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => homeController.status.value = "1",
                            child: Container(
                                height: 36,
                                width: 86,
                                decoration: BoxDecoration(
                                    color: homeController.status.value == '1'
                                        ? kPrimaryColor.withOpacity(0.5)
                                        : Colors.transparent,
                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: const Center(child: Text('Aktif'))),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.pekerjaanController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.work,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Pekerjaan',
                        hintText: 'Pekerjaan',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.pendidikanController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.school,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Pendidikan',
                        hintText: 'Pendidikan',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    color: kPrimaryLightColor,
                    child: TextField(
                      controller: homeController.jurusanController,
                      cursorColor: kPrimaryColor,
                      enabled: false,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.straighten,
                          color: kPrimaryColor,
                        ),
                        labelText: 'Jurusan',
                        hintText: 'Jurusan',
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/unverified.png'),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: const Center(
                      child: Text(
                        'Data anda belum bisa di edit,karena validasi belum selesai dilakukan,silahkan cek lagi nanti',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ));
  }
}
