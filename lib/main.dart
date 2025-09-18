import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/services/storage_services.dart';
import 'utlis/app_pages.dart';
import 'utlis/app_routes.dart';
import 'utlis/theme/theme.dart';

void main() async {
  await GetStorage.init();
  await _initServices();

  runApp(MyApp());
}

Future<void> _initServices() async {
  await Get.putAsync<StorageServices>(() async => StorageServices());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );

  }
}
