import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/pages/auth/sigin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResertPage extends StatelessWidget {
  const ResertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SigninController signinController = Get.put(SigninController());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
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
                TextFieldContainer(
                  color: kPrimaryLightColor,
                  child: TextField(
                    controller: signinController.emailresertController,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.verified_user,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Email Anda',
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
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
                          text: "RESET PASSWORD",
                          press: () {
                            if (signinController.emailresertController.text ==
                                '') {
                              Get.snackbar(
                                  'Error', 'Silahkan Isi Alamat Email anda',
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 12.0),
                                  titleText: const Text(
                                    'Error',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ));
                            } else {
                              signinController.submitResert();
                            }
                          },
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
