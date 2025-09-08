import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/c_chart/retailer/retailer_bindind.dart';
import 'package:travell_booking_app/presentation/demo/demo_screen.dart';
import 'package:travell_booking_app/presentation/my_demo/my_demo_binding.dart';
import 'package:travell_booking_app/presentation/my_demo/my_demo_screen.dart';
import 'package:travell_booking_app/presentation/tab_retailrDistributers/list_distributres_binding.dart';
import '../presentation/bindings.dart';
import '../presentation/c_chart/retailer/distributer.dart';
import '../presentation/screen.dart';
import '../presentation/splash/splash_binding.dart';
import '../presentation/splash/splash_screen.dart';
import '../presentation/tab_retailrDistributers/list_distributres.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),


    GetPage(
      name: Routes.screen,
      page: () => SettingsScreen(),
      binding: Binding(),
      transition: Transition.fade,
    ),

    GetPage(
      name: Routes.demo,
      page: () => DemoScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.myDemo,
      page: () => MyDemoScreen(),
      binding: MyDemoBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.retailers,
      page: () => AddDistributorRetailerScreen(),
      binding: RetailerBindind(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.list,
      page: () => DistributorRetailerListScreen(),
      binding: ListDistributresBinding(),
      transition: Transition.fade,
    ),
  ];
}
