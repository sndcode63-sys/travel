import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/services/storage_services.dart';
import 'utlis/app_pages.dart';
import 'utlis/app_routes.dart';
import 'utlis/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await _initServices();
  runApp(const MyApp());
}
Future<void> _initServices() async {
  await Get.putAsync<StorageServices>(() async => StorageServices());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 780),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: UAppTheme.lightTheme,
          darkTheme: UAppTheme.darkTheme,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
