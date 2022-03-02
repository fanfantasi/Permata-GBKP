import 'dart:io';

import 'package:anggota/service/constants.dart';
import 'package:anggota/service/permissions.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/components/utilities.dart';
import 'package:anggota/views/pages/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final HomeController homeController = Get.put(HomeController());

  File? imageFile;

  showFilePicker(FileType fileType) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      String? path = result.files.single.path;
      if (!mounted) return;
      checkFileSize(path!);
    }
  }

  Future<void> getData() async {
    await homeController.getKeanggota();
  }

  final _formKey = GlobalKey<FormState>();

  checkFileSize(String path) async {
    List<String> _naming = path.split('.');
    String _extension = _naming[_naming.length - 1];

    switch (Utilities.getFileType(_extension)) {
      case fileImage:
        setState(() {
          imageFile = File(path);
          homeController.photo.value = '';
          homeController.emptyphoto.value = false;
        });
        break;
      default:
        setState(() {
          imageFile = null;
        });
        homeController.photo.value = '';
        homeController.emptyphoto.value = true;
        Get.snackbar('Error', 'Photo yang dapat di upload hanya file gambar ',
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => (homeController.loadkeanggotaan.value)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (homeController.editing.value)
              ? Form(
                  key: _formKey,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Center(
                        child: SizedBox(
                          height: 125.0,
                          width: 125.0,
                          child: Stack(
                            fit: StackFit.passthrough,
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Container(
                                    padding: const EdgeInsets.all(2.0),
                                    height: 125.0,
                                    width: 125.0,
                                    child: Obx(() => (homeController
                                                .photo.value !=
                                            '')
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                homeController.photo.value,
                                            fit: BoxFit.cover,
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                Container(
                                                  width: 125,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kPrimaryColor,
                                                        width: 2.0),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                70.0)),
                                                    image: DecorationImage(
                                                        image: imageProvider),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                                      'assets/icons/ic-bgactivity.png',
                                                      height: 156.0,
                                                    ))
                                        : (imageFile == null)
                                            ? Container(
                                                width: 125,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kPrimaryColor,
                                                      width: 2.0),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              70.0)),
                                                ),
                                              )
                                            : Container(
                                                height: 125,
                                                width: 125,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kPrimaryColor,
                                                      width: 2.0),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              70.0)),
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          imageFile!)),
                                                ),
                                              ))),
                              ),
                              Positioned(
                                  bottom: 6,
                                  right: 10,
                                  child: Obx(
                                    () => (homeController.emptyphoto.value)
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 12.0),
                                            height: 115.0,
                                            width: 100.0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Add Photo',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Colors.grey,
                                                  ),
                                                  onPressed: () async =>
                                                      await Permissions
                                                              .storagePermissionsGranted()
                                                          ? showFilePicker(
                                                              FileType.any)
                                                          : {},
                                                ),
                                              ],
                                            ))
                                        : Container(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  imageFile = null;
                                                });
                                                homeController.photo.value = '';
                                                homeController
                                                    .emptyphoto.value = true;
                                              },
                                              child: const Icon(
                                                CupertinoIcons
                                                    .clear_circled_solid,
                                                size: 24,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                  ))
                            ],
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
                                // onTap: () => homeController.gender.value = "P",
                                child: Container(
                                  height: 36,
                                  width: 86,
                                  decoration: BoxDecoration(
                                      color: homeController.gender.value == 'P'
                                          ? kPrimaryColor.withOpacity(0.5)
                                          : Colors.transparent,
                                      border: Border.all(color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: const Center(child: Text('Wanita')),
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                // onTap: () => homeController.gender.value = "L",
                                child: Container(
                                  height: 36,
                                  width: 86,
                                  decoration: BoxDecoration(
                                      color: homeController.gender.value == 'L'
                                          ? kPrimaryColor.withOpacity(0.5)
                                          : Colors.transparent,
                                      border: Border.all(color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: const Center(child: Text('Pria')),
                                ),
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
                        color: Colors.white,
                        child: TextField(
                          controller: homeController.telpController,
                          cursorColor: kPrimaryColor,
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
                        color: Colors.white,
                        child: TextFormField(
                          validator: EmailValidator(
                              errorText: 'Alamat Email tidak valid'),
                          controller: homeController.emailController,
                          cursorColor: kPrimaryColor,
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
                        child: TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Harap isi nomor handphone'),
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
                                onTap: () =>
                                    homeController.sttsAnggota.value = "0",
                                child: Container(
                                    height: 36,
                                    width: 86,
                                    decoration: BoxDecoration(
                                        color:
                                            homeController.sttsAnggota.value ==
                                                    '0'
                                                ? kPrimaryColor.withOpacity(0.5)
                                                : Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: const Center(child: Text('Biasa'))),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () =>
                                    homeController.sttsAnggota.value = "1",
                                child: Container(
                                    height: 36,
                                    width: 86,
                                    decoration: BoxDecoration(
                                        color:
                                            homeController.sttsAnggota.value ==
                                                    '1'
                                                ? kPrimaryColor.withOpacity(0.5)
                                                : Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: const Center(
                                        child: Text('Luar Biasa'))),
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
                                        color:
                                            homeController.status.value == '0'
                                                ? kPrimaryColor.withOpacity(0.5)
                                                : Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: const Center(
                                        child: Text('Tidak Aktif'))),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () => homeController.status.value = "1",
                                child: Container(
                                    height: 36,
                                    width: 86,
                                    decoration: BoxDecoration(
                                        color:
                                            homeController.status.value == '1'
                                                ? kPrimaryColor.withOpacity(0.5)
                                                : Colors.transparent,
                                        border:
                                            Border.all(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: const Center(child: Text('Aktif'))),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Obx(
                        () => TextFieldContainer(
                          color: Colors.white,
                          child: DropdownButtonFormField(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFF777777),
                            ),
                            value: homeController.pekerjaan.value,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.work,
                                color: kPrimaryColor,
                              ),
                              labelText: 'Pekerjaan',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                              hintStyle: TextStyle(color: Colors.black54),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                            ),
                            onChanged: (newValue) {
                              homeController.pekerjaan.value =
                                  newValue.toString();
                              int i = homeController.listpekerjaan.indexWhere(
                                  (element) => element.pekerjaan == newValue);
                              homeController.pekerjaanid.value =
                                  homeController.listpekerjaan[i].id.toString();
                            },
                            items: homeController.listpekerjaan.map((p) {
                              return DropdownMenuItem(
                                child: Text(
                                  p.pekerjaan,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                value: p.pekerjaan,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Obx(
                        () => TextFieldContainer(
                          color: Colors.white,
                          child: DropdownButtonFormField(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFF777777),
                            ),
                            value: homeController.pendidikan.value,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.school,
                                color: kPrimaryColor,
                              ),
                              labelText: 'Pendidikan',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                              hintStyle: TextStyle(color: Colors.black54),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E2E2),
                                  width: .5,
                                ),
                              ),
                            ),
                            onChanged: (newValue) {
                              homeController.pendidikan.value =
                                  newValue.toString();
                              int i = homeController.listpendidikan.indexWhere(
                                  (element) => element.pendidikan == newValue);
                              homeController.pendidikanid.value = homeController
                                  .listpendidikan[i].id
                                  .toString();
                            },
                            items: homeController.listpendidikan.map((p) {
                              return DropdownMenuItem(
                                child: Text(
                                  p.pendidikan,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                value: p.pendidikan,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        color: Colors.white,
                        child: TextField(
                          controller: homeController.jurusanController,
                          cursorColor: kPrimaryColor,
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
                      Obx(() => (homeController.updated.value)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : RoundedButton(
                              text: "UPDATE",
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  homeController.updateAnggota(imageFile);
                                }
                              },
                            )),
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
    ));
  }
}
