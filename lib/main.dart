import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utlis/app_pages.dart';
import 'utlis/app_routes.dart';
import 'utlis/storage/secure_local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecureLocalStorageService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My App",
      initialRoute: Routes.retailers,
      getPages: AppPages.routes,
    );
  }
}
