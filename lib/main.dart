import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/services/api_manager.dart';
import 'data/services/storage_services.dart';
import 'utlis/app_pages.dart';
import 'utlis/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await _initServices();


  runApp(const MyApp());
}

Future<void> _initServices() async {
  await Get.putAsync<StorageServices>(() async => StorageServices());
  await Get.putAsync<AuthService>(() async => AuthService().init());
  await Get.putAsync<ThemeController1>(() async => ThemeController1());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController1>();
    return ScreenUtilInit(
      designSize: const Size(390, 780),
      minTextAdapt: true,
      builder: (context, child) {
        return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,

          themeMode: themeCtrl.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,

          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.grey[100],
            primaryColor: themeCtrl.accentColor.value,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: themeCtrl.accentColor.value,
            ),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            primaryColor: themeCtrl.accentColor.value,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: themeCtrl.accentColor.value,
            ),
          ),

          initialRoute: AppRoutes.splash,
          getPages: AppPages.routes,
        ));

      },
    );
  }
}


class ThemeController1 extends GetxController {
  final _box = GetStorage();

  // Use Color type (not MaterialColor)
  Rx<Color> accentColor = Colors.blue.obs;
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final savedColor = _box.read('accentColor');
    if (savedColor != null) {
      accentColor.value = Color(savedColor);
    }
    isDarkMode.value = _box.read('darkMode') ?? false;
  }

  /// Public API to change accent color
  void changeAccent(Color color) {
    accentColor.value = color;
    _box.write('accentColor', color.value);
  }

  /// Adds toggleDarkMode so your UI switch can call it
  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    _box.write('darkMode', value);
    // If you also want to expose ThemeMode, you can add additional logic here.
  }
}
class ColorSelectorSheet extends StatelessWidget {
  final themeCtrl = Get.find<ThemeController1>();

  final List<Map<String, dynamic>> colors = [
    {"name": "Red", "color": Colors.red},
    {"name": "Green", "color": Colors.green},
    {"name": "Blue", "color": Colors.blue},
    {"name": "Mint", "color": Colors.tealAccent.shade700},
    {"name": "Orange", "color": Colors.orange},
    {"name": "Yellow", "color": Colors.yellow.shade700},
    {"name": "Magenta", "color": Colors.purple},
    {"name": "Brown", "color": Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Text("Color your ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text("PayApp",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Tap to change the color accent of PayApp"),
          const SizedBox(height: 20),

          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: colors
                .map((item) => GestureDetector(
              onTap: () => themeCtrl.changeAccent(item["color"]),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: item["color"],
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(item["name"]),
                ],
              ),
            ))
                .toList(),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
class CustomDrawer extends StatelessWidget {
  final themeCtrl = Get.find<ThemeController1>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(28)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themeCtrl.accentColor.value.withOpacity(0.18),
                themeCtrl.accentColor.value.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: [
              const SizedBox(height: 40),

              // Profile (+ Welcome)
              Row(
                children: [
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Back",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600)),
                      Text(
                        "Enabled",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: themeCtrl.accentColor.value,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: themeCtrl.accentColor.value,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),

                ],
              ),

              const SizedBox(height: 30),

              drawerItem(Icons.favorite, "Welcome"),
              drawerItem(Icons.apps, "Page Packs"),
              drawerItem(Icons.style, "Home Styles"),
              drawerItem(Icons.widgets, "Components"),
              GestureDetector(
                onTap: (){
                  ColorSelectorSheet();
                },
                child: drawerItem(Icons.color_lens, "Color Theme",
                    trailingIcon: Icons.chevron_right,),
              ),

              // Dark Mode Toggle
              Obx(() => ListTile(
                leading: Icon(Icons.light_mode,
                    color: themeCtrl.accentColor.value),
                title: const Text("Dark Mode"),
                trailing: Switch(
                  value: themeCtrl.isDarkMode.value,
                  activeColor: themeCtrl.accentColor.value,
                  onChanged: (v) => themeCtrl.toggleDarkMode(v),
                ),
              )),

              const SizedBox(height: 28),

              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  quickAction(Icons.upload, "Transfer"),
                  quickAction(Icons.call_received, "Request"),
                  quickAction(Icons.sync_alt, "Exchange"),
                ],
              ),

              const SizedBox(height: 30),
              Divider(),

              Text("Useful Links",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold)),

              drawerItem(Icons.support, "Support"),
              drawerItem(Icons.person_outline, "Account"),
              drawerItem(Icons.logout, "Log Out", trailingIcon: Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerItem(IconData icon, String label, {IconData? trailingIcon}) {
    return Obx(
          () => ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themeCtrl.accentColor.value.withOpacity(0.15),
          ),
          child: Icon(icon, color: themeCtrl.accentColor.value),
        ),
        title: Text(label, style: const TextStyle(fontSize: 16)),
        trailing: trailingIcon != null
            ? Icon(trailingIcon,
            color: themeCtrl.accentColor.value.withOpacity(0.6))
            : null,
      ),
    );
  }

  Widget quickAction(IconData icon, String label) {
    return Obx(
          () => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeCtrl.accentColor.value.withOpacity(0.15),
            ),
            child: Icon(icon, color: themeCtrl.accentColor.value, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label)
        ],
      ),
    );
  }
}
