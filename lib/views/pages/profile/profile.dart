import 'package:anggota/service/constants.dart';
import 'package:anggota/views/pages/dashboard/dashboard_controller.dart';
import 'package:anggota/views/pages/profile/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  String photo = '';
  String email = '';
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    await GetStorage.init();
    final box = Get.find<GetStorage>();
    photo = box.read('photo');
    email = box.read('email');
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dashboardController.name.value.toString(),
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  )),
                  CircleAvatar(
                    radius: 22,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue[50],
                      child: CachedNetworkImage(
                        cacheKey: photo,
                        // ignore: unnecessary_string_interpolations
                        imageUrl: photo,
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 125,
                          height: 125.0,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: kPrimaryColor, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(70.0)),
                            image: DecorationImage(image: imageProvider),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 125.0,
                          height: 125.0,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: kPrimaryColor, width: 2.0),
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
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15.0, top: 8.0),
            height: 36.0,
            child: const Text(
              'User settings',
              style: TextStyle(color: Color(0xFF4B61DD)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0.0),
            color: Colors.white,
            child: ListTile(
              title: const Text('Profil'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
                color: Color(0xFF4B61DD),
              ),
              onTap: () {
                Get.toNamed('/changeprofile',
                    arguments: dashboardController.uid.value);
              },
            ),
          ),
          const Divider(
            height: 1,
            indent: 16.0,
          ),
          Container(
            margin: const EdgeInsets.only(top: 0.0),
            color: Colors.white,
            child: ListTile(
              title: const Text('Ganti Password'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
                color: Color(0xFF4B61DD),
              ),
              onTap: () {
                Get.toNamed('/password',
                    arguments: dashboardController.uid.value);
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15.0, top: 8.0),
            height: 36.0,
            child: const Text(
              'About Us',
              style: TextStyle(color: Color(0xFF4B61DD)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            color: Colors.white,
            child: const ListTile(
              title: Text('About Us'),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
                color: Color(0xFF4B61DD),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await Get.dialog(AlertDialog(
                      title: const Text('Keluar'),
                      content: Text(
                          'Apakah yakin ingin keluar dari Mobile Apps $titlelab?'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Batal"),
                          onPressed: () {
                            Get.back(result: false);
                          },
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text("Log Out"),
                          onPressed: () async {
                            Get.back(result: false);
                            await profileController.logOut();
                          },
                        )
                      ],
                    ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Keluar',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Colors.white,
                  ),
                ),
              )),
          Obx(
            () => Visibility(
              visible: profileController.version.value != '' &&
                  profileController.buildNumber.value != '',
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'v.' +
                      profileController.version.value +
                      ' (' +
                      profileController.buildNumber.value +
                      ')',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    )));
  }
}
