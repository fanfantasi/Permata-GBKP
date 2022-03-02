import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/rounded_button.dart';
import 'package:anggota/views/components/rounded_password_field.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:anggota/views/pages/auth/sigin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

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
                    controller: signinController.usernameController,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.verified_user,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Username',
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                RoundedPasswordField(
                  text: 'Password',
                  color: kPrimaryLightColor,
                  onChanged: (value) {
                    signinController.passwordController.text = value;
                  },
                ),
                Obx(
                  () => (signinController.loading.value)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RoundedButton(
                          text: "LOGIN",
                          press: () {
                            signinController.signIn();
                          },
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
