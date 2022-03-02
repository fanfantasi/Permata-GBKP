import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/rounded_password_field.dart';
import 'package:anggota/views/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ganti Password'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/logo_512x512.png",
                  height: size.height * 0.2,
                ),
                Text(
                  juahjuah,
                  style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                Text(
                  "Apps Mobile $titlelab",
                  style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(height: size.height * 0.03),
                RoundedPasswordField(
                  text: 'Password Lama',
                  color: kPrimaryLightColor,
                  onChanged: (value) {
                    profileController.oldpasswordController.text = value;
                  },
                ),
                RoundedPasswordField(
                  text: 'Password Baru',
                  color: kPrimaryLightColor,
                  onChanged: (value) {
                    profileController.passwordController.text = value;
                  },
                ),
                Obx(
                  () => (profileController.submitpassword.value)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RoundedButton(
                          text: "Ganti Password",
                          press: () {
                            profileController.changepassword();
                          },
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
