import 'dart:io';

import 'package:anggota/service/constants.dart';
import 'package:anggota/service/permissions.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/components/utilities.dart';
import 'package:anggota/views/pages/profile/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  ProfileController profileController = Get.put(ProfileController());
  File? imageFile;

  @override
  void initState() {
    super.initState();
    profileController.getProfile();
  }

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
          profileController.photo.value = '';
          profileController.emptyphoto.value = false;
        });
        break;
      default:
        setState(() {
          imageFile = null;
        });
        profileController.photo.value = '';
        profileController.emptyphoto.value = true;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Apps Mobile $titlelab",
                  style: const TextStyle(
                      fontSize: 22.0,
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
                              padding: const EdgeInsets.all(2.0),
                              height: 125.0,
                              width: 125.0,
                              child: Obx(() => (profileController.photo.value !=
                                      '')
                                  ? CachedNetworkImage(
                                      imageUrl: profileController.photo.value,
                                      fit: BoxFit.cover,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            width: 125,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: kPrimaryColor,
                                                  width: 2.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(70.0)),
                                              image: DecorationImage(
                                                  image: imageProvider),
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
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
                                                    Radius.circular(70.0)),
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
                                                    Radius.circular(70.0)),
                                            image: DecorationImage(
                                                image: FileImage(imageFile!)),
                                          ),
                                        ))),
                        ),
                        Positioned(
                            bottom: 6,
                            right: 10,
                            child: Obx(
                              () => (profileController.emptyphoto.value)
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
                                            'Add Photo',
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                          profileController.photo.value = '';
                                          profileController.emptyphoto.value =
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
                TextFieldContainer(
                  color: kPrimaryLightColor,
                  child: TextField(
                    controller: profileController.namaController,
                    cursorColor: kPrimaryColor,
                    enabled: false,
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
                    controller: profileController.emailController,
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
                    controller: profileController.telpController,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Telp',
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Obx(
                  () => (profileController.submit.value)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RoundedButton(
                          text: "Update Profil",
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              profileController.updateProfile(imageFile);
                            }
                          },
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
