import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anggota/service/constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: size.width / 1.4,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Center(
                child: Text(
                  "\"Mejuah-juah",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor),
                ),
              ),
              const Center(
                child: Text(
                  "Selamat datang di Apps PERMATA GBKP KU\"",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
              ),
              const SizedBox(
                height: 26.0,
              ),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Silahkan  ",
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      TextSpan(
                          text: "Login disini",
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed('/signin');
                            }),
                    ])),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Jika anda belum terdaftar, Silahkan ",
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ])),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: size.width * 0.9,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: ElevatedButton(
                      child: const Text(
                        'Daftar disini',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          textStyle: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    )),
              ),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Lupa Password ?  ",
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      TextSpan(
                          text: "Disini",
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed('/resert');
                            }),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
