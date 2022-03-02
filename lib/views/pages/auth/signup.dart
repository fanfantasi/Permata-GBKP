import 'dart:io';

import 'package:anggota/service/constants.dart';
import 'package:anggota/service/permissions.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/rounded_password_field.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/components/utilities.dart';
import 'package:anggota/views/pages/auth/sigin_controller.dart';
import 'package:anggota/views/widgets/focusnode.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SigninController signinController = Get.put(SigninController());
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

  final _formKey = GlobalKey<FormState>();

  checkFileSize(String path) async {
    List<String> _naming = path.split('.');
    String _extension = _naming[_naming.length - 1];

    switch (Utilities.getFileType(_extension)) {
      case fileImage:
        setState(() {
          imageFile = File(path);
          signinController.photo.value = '';
          signinController.emptyphoto.value = false;
        });
        break;
      default:
        setState(() {
          imageFile = null;
        });
        signinController.photo.value = '';
        signinController.emptyphoto.value = true;
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
  void initState() {
    super.initState();
    () {
      getData().then((value) async {
        if (value) {
          await signinController.getrunggun();
          await signinController.getPerulungen();
          await signinController.getPekerjaan();
          await signinController.getPendidikan();
        }
      });
    }();
  }

  Future<bool> getData() async {
    await signinController.getKlasis();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: const Text('Registrasi'),
        ),
        body: Obx(() => (signinController.loading.value)
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Container(
                    width: size.width,
                    height: size.height,
                    color: kPrimaryColor,
                    alignment: Alignment.topCenter,
                    child: ListView(
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          fit: StackFit.loose,
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 85.0),
                              width: size.width,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0))),
                              child: Column(
                                children: [
                                  const SizedBox(height: 85),
                                  Text(
                                    juahjuah,
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  Text(
                                    "Apps Mobile $titlelab",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(height: size.height * 0.03),
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
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  height: 125.0,
                                                  width: 125.0,
                                                  child: (imageFile == null)
                                                      ? Container(
                                                          width: 125,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    kPrimaryColor,
                                                                width: 2.0),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        70.0)),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 125,
                                                          width: 125,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    kPrimaryColor,
                                                                width: 2.0),
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        70.0)),
                                                            image: DecorationImage(
                                                                image: FileImage(
                                                                    imageFile!)),
                                                          ),
                                                        ))),
                                          Positioned(
                                              bottom: 6,
                                              right: 10,
                                              child: Obx(
                                                () => (signinController
                                                        .emptyphoto.value)
                                                    ? Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 12.0,
                                                                horizontal:
                                                                    12.0),
                                                        height: 115.0,
                                                        width: 100.0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                              'Add Photo',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              onPressed: () async =>
                                                                  await Permissions
                                                                          .storagePermissionsGranted()
                                                                      ? showFilePicker(
                                                                          FileType
                                                                              .any)
                                                                      : {},
                                                            ),
                                                          ],
                                                        ))
                                                    : Container(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              imageFile = null;
                                                            });
                                                            signinController
                                                                .emptyphoto
                                                                .value = true;
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
                                    color: Colors.white,
                                    child: TextFormField(
                                      controller:
                                          signinController.nikController,
                                      cursorColor: kPrimaryColor,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'NIK Wajib Diisi'),
                                        MinLengthValidator(16,
                                            errorText:
                                                'NIK Minimal 16 Karakter'),
                                      ]),
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.card_membership,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'NIK',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    color: Colors.white,
                                    child: TextFormField(
                                      validator: RequiredValidator(
                                          errorText: 'Username wajib diisi'),
                                      controller: signinController
                                          .usernamesigninController,
                                      cursorColor: kPrimaryColor,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.verified_user,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Username',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    color: Colors.white,
                                    child: TextFormField(
                                      validator: RequiredValidator(
                                          errorText:
                                              'Nama Lengkap wajib diisi'),
                                      controller: signinController
                                          .namalengkapController,
                                      cursorColor: kPrimaryColor,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.person,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Nama Lengkap',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    color: Colors.white,
                                    child: TextFormField(
                                      validator: RequiredValidator(
                                          errorText:
                                              'Tempat Lahir wajib diisi'),
                                      controller:
                                          signinController.tmplahirController,
                                      cursorColor: kPrimaryColor,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.location_on,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Tempat Lahir',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    color: Colors.white,
                                    child: TextFormField(
                                      controller:
                                          signinController.tgllahirController,
                                      cursorColor: kPrimaryColor,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.date_range,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Tanggal Lahir',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        border: InputBorder.none,
                                      ),
                                      focusNode: AlwaysDisabledFocusNode(),
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Text("Jenis Kelamin"),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () => signinController
                                                  .gender.value = "P",
                                              child: Container(
                                                height: 36,
                                                width: 86,
                                                decoration: BoxDecoration(
                                                    color: signinController
                                                                .gender.value ==
                                                            'P'
                                                        ? kPrimaryColor
                                                            .withOpacity(0.5)
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                        color: Colors.black54),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0)),
                                                child: const Center(
                                                    child: Text('Wanita')),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            GestureDetector(
                                              onTap: () => signinController
                                                  .gender.value = "L",
                                              child: Container(
                                                height: 36,
                                                width: 86,
                                                decoration: BoxDecoration(
                                                    color: signinController
                                                                .gender.value ==
                                                            'L'
                                                        ? kPrimaryColor
                                                            .withOpacity(0.5)
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                        color: Colors.black54),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0)),
                                                child: const Center(
                                                    child: Text('Pria')),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextFieldContainer(
                                    color: Colors.white,
                                    child: TextFormField(
                                      controller:
                                          signinController.telpController,
                                      cursorColor: kPrimaryColor,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.phone_android,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'No. Handphone',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    color: Colors.white,
                                    child: TextFormField(
                                      validator: EmailValidator(
                                          errorText:
                                              'Alamat email tidak valid'),
                                      controller:
                                          signinController.emailController,
                                      cursorColor: kPrimaryColor,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.email,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Email',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  RoundedPasswordField(
                                    text: 'Password',
                                    color: Colors.white,
                                    onChanged: (value) {
                                      signinController.passwordController.text =
                                          value;
                                    },
                                  ),
                                  Obx(
                                    () => TextFieldContainer(
                                      color: Colors.white,
                                      child: DropdownButtonFormField(
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color(0xFF777777),
                                        ),
                                        value:
                                            signinController.klasisname.value,
                                        decoration: const InputDecoration(
                                          icon: Icon(
                                            Icons.check_box,
                                            color: kPrimaryColor,
                                          ),
                                          labelText: 'Klasis',
                                          labelStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
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
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE2E2E2),
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        onChanged: (newValue) async {
                                          signinController.klasisname.value =
                                              newValue.toString();
                                          int i = signinController.listklasis
                                              .indexWhere((element) =>
                                                  element.klasis == newValue);
                                          signinController.klasisid.value =
                                              signinController.listklasis[i].id
                                                  .toString();
                                          await signinController.getrunggun();
                                        },
                                        items: signinController.listklasis
                                            .map((p) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              p.klasis,
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            value: p.klasis,
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
                                        value:
                                            signinController.runggunname.value,
                                        decoration: const InputDecoration(
                                          icon: Icon(
                                            Icons.check_box,
                                            color: kPrimaryColor,
                                          ),
                                          labelText: 'Runggun',
                                          labelStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
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
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE2E2E2),
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        onChanged: (newValue) async {
                                          signinController.runggunname.value =
                                              newValue.toString();
                                          int i = signinController.listrunggun
                                              .indexWhere((element) =>
                                                  element.runggun == newValue);
                                          signinController.runggunid.value =
                                              signinController.listrunggun[i].id
                                                  .toString();
                                          await signinController
                                              .getPerulungen();
                                        },
                                        items: signinController.listrunggun
                                            .map((p) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              p.runggun,
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            value: p.runggun,
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
                                        value: signinController
                                            .perpulungenname.value,
                                        decoration: const InputDecoration(
                                          icon: Icon(
                                            Icons.check_box,
                                            color: kPrimaryColor,
                                          ),
                                          labelText: 'Perpulungen',
                                          labelStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
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
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE2E2E2),
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        onChanged: (newValue) {
                                          signinController.perpulungenname
                                              .value = newValue.toString();
                                          int i = signinController
                                              .listperpulungen
                                              .indexWhere((element) =>
                                                  element.perpulungen ==
                                                  newValue);
                                          signinController.perpulungenid.value =
                                              signinController
                                                  .listperpulungen[i].id
                                                  .toString();
                                        },
                                        items: signinController.listperpulungen
                                            .map((p) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              p.perpulungen,
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            value: p.perpulungen,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Text("Status Keanggotaan"),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () => signinController
                                                  .sttsAnggota.value = "0",
                                              child: Container(
                                                  height: 36,
                                                  width: 86,
                                                  decoration: BoxDecoration(
                                                      color: signinController
                                                                  .sttsAnggota
                                                                  .value ==
                                                              '0'
                                                          ? kPrimaryColor
                                                              .withOpacity(0.5)
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          color:
                                                              Colors.black54),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0)),
                                                  child: const Center(
                                                      child: Text('Biasa'))),
                                            ),
                                            const SizedBox(width: 4),
                                            GestureDetector(
                                              onTap: () => signinController
                                                  .sttsAnggota.value = "1",
                                              child: Container(
                                                  height: 36,
                                                  width: 86,
                                                  decoration: BoxDecoration(
                                                      color: signinController
                                                                  .sttsAnggota
                                                                  .value ==
                                                              '1'
                                                          ? kPrimaryColor
                                                              .withOpacity(0.5)
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          color:
                                                              Colors.black54),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0)),
                                                  child: const Center(
                                                      child:
                                                          Text('Luar Biasa'))),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0, vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 8.0, top: 12.0),
                                          child: Text("Status"),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () => signinController
                                                  .status.value = "0",
                                              child: Container(
                                                  height: 36,
                                                  width: 86,
                                                  decoration: BoxDecoration(
                                                      color: signinController
                                                                  .status
                                                                  .value ==
                                                              '0'
                                                          ? kPrimaryColor
                                                              .withOpacity(0.5)
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          color:
                                                              Colors.black54),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0)),
                                                  child: const Center(
                                                      child:
                                                          Text('Tidak Aktif'))),
                                            ),
                                            const SizedBox(width: 4),
                                            GestureDetector(
                                              onTap: () => signinController
                                                  .status.value = "1",
                                              child: Container(
                                                  height: 36,
                                                  width: 86,
                                                  decoration: BoxDecoration(
                                                      color: signinController
                                                                  .status
                                                                  .value ==
                                                              '1'
                                                          ? kPrimaryColor
                                                              .withOpacity(0.5)
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          color:
                                                              Colors.black54),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0)),
                                                  child: const Center(
                                                      child: Text('Aktif'))),
                                            ),
                                          ],
                                        ),
                                      ],
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
                                        value: signinController.pekerjaan.value,
                                        decoration: const InputDecoration(
                                          icon: Icon(
                                            Icons.work,
                                            color: kPrimaryColor,
                                          ),
                                          labelText: 'Pekerjaan',
                                          labelStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
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
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE2E2E2),
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        onChanged: (newValue) {
                                          signinController.pekerjaan.value =
                                              newValue.toString();
                                          int i = signinController.listpekerjaan
                                              .indexWhere((element) =>
                                                  element.pekerjaan ==
                                                  newValue);
                                          signinController.pekerjaanid.value =
                                              signinController
                                                  .listpekerjaan[i].id
                                                  .toString();
                                        },
                                        items: signinController.listpekerjaan
                                            .map((p) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              p.pekerjaan,
                                              style: const TextStyle(
                                                  fontSize: 16.0),
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
                                        value:
                                            signinController.pendidikan.value,
                                        decoration: const InputDecoration(
                                          icon: Icon(
                                            Icons.school,
                                            color: kPrimaryColor,
                                          ),
                                          labelText: 'Pendidikan',
                                          labelStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
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
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE2E2E2),
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        onChanged: (newValue) {
                                          signinController.pendidikan.value =
                                              newValue.toString();
                                          int i = signinController
                                              .listpendidikan
                                              .indexWhere((element) =>
                                                  element.pendidikan ==
                                                  newValue);
                                          signinController.pendidikanid.value =
                                              signinController
                                                  .listpendidikan[i].id
                                                  .toString();
                                        },
                                        items: signinController.listpendidikan
                                            .map((p) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              p.pendidikan,
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            value: p.pendidikan,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  TextFieldContainer(
                                    color: Colors.white,
                                    child: TextFormField(
                                      controller:
                                          signinController.jurusanController,
                                      cursorColor: kPrimaryColor,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.straighten,
                                          color: kPrimaryColor,
                                        ),
                                        labelText: 'Jurusan',
                                        hintText: 'Jurusan',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => (signinController.submit.value)
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : RoundedButton(
                                            text: "REGISTRASI",
                                            press: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                signinController
                                                    .submitRegistrasi(
                                                        imageFile!.path);
                                              }
                                            },
                                          ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset(
                                  "assets/icons/logo_512x512.png",
                                  height: size.height * 0.2,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              )));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: signinController.selectedDate,
        firstDate: DateTime(1945, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != signinController.selectedDate) {
      setState(() {
        signinController.selectedDate = picked;
        signinController.tgllahirController.text =
            DateFormat('d MMM y').format(picked);
      });
    }
  }
}
