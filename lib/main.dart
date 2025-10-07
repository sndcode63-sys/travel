import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/services/api_manager.dart';
import 'data/services/storage_services.dart';
import 'presentation/theme/theme_controller.dart';
import 'utlis/app_pages.dart';
import 'utlis/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());

  await GetStorage.init();

  await _initServices();

  runApp(const MyApp());
}

Future<void> _initServices() async {
  await Get.putAsync<StorageServices>(() async => StorageServices());

  await Get.putAsync<AuthService>(() async => AuthService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return ScreenUtilInit(
      designSize: const Size(390, 780),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeController.themeMode.value,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.grey[100],
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 1,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: themeController.primaryColor.value,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey[900],
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 1,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: themeController.primaryColor.value,
            ),
          ),
          initialRoute: AppRoutes.splash,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
