import 'dart:io';

import 'package:anggota/service/constants.dart';
import 'package:anggota/service/permissions.dart';
import 'package:anggota/views/components/formatter.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/components/utilities.dart';
import 'package:anggota/views/pages/upload/transaksi.dart';
import 'package:anggota/views/pages/upload/upload_controller.dart';
import 'package:anggota/views/widgets/focusnode.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final UploadController uploadController = Get.put(UploadController());
  File? imageFile;
  final _formKey = GlobalKey<FormState>();

  showFilePicker(FileType fileType) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      String? path = result.files.single.path;
      if (!mounted) return;
      checkFileSize(path!);
    }
  }

  checkFileSize(String path) async {
    List<String> _naming = path.split('.');
    String _extension = _naming[_naming.length - 1];

    switch (Utilities.getFileType(_extension)) {
      case fileImage:
        setState(() {
          imageFile = File(path);
          uploadController.photo.value = '';
          uploadController.emptyphoto.value = false;
        });
        break;
      default:
        setState(() {
          imageFile = null;
        });
        uploadController.photo.value = '';
        uploadController.emptyphoto.value = true;
        Get.snackbar(
            'Error', 'Bukti Transfer yang dapat di upload hanya file gambar ',
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
      appBar: AppBar(
        title: const Text('Upload Bukti Pembayaran'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                elevation: 1.0,
                child: Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  color: Colors.white,
                  child: ListTile(
                    title: const Text('No. Transaksi'),
                    subtitle: Obx(() => Visibility(
                        visible: uploadController.notrans.value != '',
                        child: Text('${uploadController.notrans}'))),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Color(0xFF4B61DD),
                    ),
                    onTap: () async {
                      await Get.generalDialog(
                        routeSettings: const RouteSettings(name: '/transaksi'),
                        barrierLabel: "transaksi",
                        barrierDismissible: false,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: const Duration(milliseconds: 100),
                        pageBuilder: (context, anim1, anim2) {
                          return const ListTransaksiPage();
                        },
                        transitionBuilder: (context, anim1, anim2, child) {
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
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: uploadController.jenis.value != '',
                  child: Card(
                      elevation: 1.0,
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8.0),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 36.0,
                                color: Colors.black12,
                                child: const Center(
                                  child: Text(
                                    'List Transaksi Pembelian Buku Anda',
                                    style: TextStyle(color: Color(0xFF626B79)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Text(uploadController.jenis.value,
                                    style: const TextStyle(
                                        color: Color(0xFF626B79),
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Text(
                                    'Rp. ${Formatter.number(uploadController.harga.value.toDouble())}',
                                    style: const TextStyle(
                                        color: Color(0xFF626B79),
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Text(uploadController.rek.value,
                                    style: const TextStyle(
                                        color: Color(0xFF626B79),
                                        fontWeight: FontWeight.bold)),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0),
                                child: Text(
                                    '*) Harap Bayar sesuai dengan jumlah yang ditentukan, demi memudahkan kami dalam melakukan pengecekan',
                                    style: TextStyle(color: Color(0xFF626B79))),
                              ),
                            ],
                          ))),
                ),
              ),
              TextFieldContainer(
                color: Colors.white,
                child: TextFormField(
                  controller: uploadController.namaController,
                  cursorColor: kPrimaryColor,
                  validator:
                      RequiredValidator(errorText: 'Nama Lengkap Wajib Diisi'),
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Nama Lengkap',
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                color: Colors.white,
                child: TextFormField(
                  validator:
                      EmailValidator(errorText: 'Alamat email tidak valid'),
                  controller: uploadController.emailController,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Email',
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                color: Colors.white,
                child: TextFormField(
                  controller: uploadController.tglController,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.date_range,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Tanggal Bayar',
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    border: InputBorder.none,
                  ),
                  focusNode: AlwaysDisabledFocusNode(),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
              TextFieldContainer(
                color: Colors.white,
                child: TextFormField(
                  validator:
                      RequiredValidator(errorText: 'Nama Bank Harus Diisi'),
                  controller: uploadController.bankController,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.account_balance,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Nama Bank Anda/Ulang Elektronik',
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                color: Colors.white,
                child: TextFormField(
                  validator: RequiredValidator(errorText: 'No. Rekening'),
                  controller: uploadController.norekController,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.account_balance_wallet,
                      color: kPrimaryColor,
                    ),
                    hintText: 'No Rekening Anda/Ulang Elektronik',
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                color: Colors.white,
                child: TextFormField(
                  controller: uploadController.pesanController,
                  cursorColor: kPrimaryColor,
                  maxLength: 225,
                  maxLines: null,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.message,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Pesan',
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
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
                              child: (imageFile == null)
                                  ? Container(
                                      width: 125,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kPrimaryColor, width: 2.0),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                    )
                                  : Container(
                                      height: 125,
                                      width: 125,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kPrimaryColor, width: 2.0),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                        image: DecorationImage(
                                            image: FileImage(imageFile!)),
                                      ),
                                    ))),
                      Positioned(
                          bottom: 6,
                          right: 10,
                          child: Obx(
                            () => (uploadController.emptyphoto.value)
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 12.0),
                                    height: 115.0,
                                    width: 100.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Bukti',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () async => await Permissions
                                                  .storagePermissionsGranted()
                                              ? showFilePicker(FileType.any)
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
                                        uploadController.emptyphoto.value =
                                            true;
                                      },
                                      child: const Icon(
                                        CupertinoIcons.clear_circled_solid,
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
              Obx(
                () => (uploadController.submit.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RoundedButton(
                        text: "Bayar",
                        press: () {
                          if (uploadController.notrans.value == '') {
                            Get.snackbar(
                                'Error', 'No. Transaksi belum ditentukan.',
                                colorText: Colors.black87,
                                backgroundColor: Colors.white.withOpacity(.9),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12.0),
                                titleText: const Text(
                                  'Error',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ));
                          } else if (imageFile == null) {
                            Get.snackbar('Error',
                                'Silahkan upload bukti pembayaran anda.',
                                colorText: Colors.black87,
                                backgroundColor: Colors.white.withOpacity(.9),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12.0),
                                titleText: const Text(
                                  'Error',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ));
                          } else {
                            uploadController.uploadbukti(imageFile!.path);
                          }
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: uploadController.selectedDate,
        firstDate: DateTime(1945, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != uploadController.selectedDate) {
      setState(() {
        uploadController.selectedDate = picked;
        uploadController.tglController.text =
            DateFormat('d MMM y').format(picked);
      });
    }
  }
}
