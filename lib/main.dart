import 'package:anggota/routes/app_pages.dart';
import 'package:anggota/routes/app_routes.dart';
import 'package:anggota/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'views/pages/unknown.dart';

void main() {
  Get.put<GetStorage>(GetStorage());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anggota BGKP',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      unknownRoute:
          GetPage(name: '/notfound', page: () => const UnknownScreen()),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPages.list,
    );
  }
}
