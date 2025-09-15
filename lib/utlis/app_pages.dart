import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information_binding.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_binding.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_screen.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_info_screen.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_infro_binding.dart';
import 'package:travell_booking_app/presentation/auth/login/login_binding.dart';
import 'package:travell_booking_app/presentation/auth/login/login_screen.dart';
import 'package:travell_booking_app/presentation/auth/otp/otp_verification_binding.dart';
import 'package:travell_booking_app/presentation/auth/otp/otp_verification_screen.dart';
import 'package:travell_booking_app/presentation/auth/password/forget_password_binding.dart';
import 'package:travell_booking_app/presentation/auth/password/forget_password_screen.dart';
import 'package:travell_booking_app/presentation/auth/reset_password/reset_password_binding.dart';
import 'package:travell_booking_app/presentation/dashBoard/bottom_navigation_bar.dart';
import 'package:travell_booking_app/presentation/dashBoard/dash_board_screen.dart';
import 'package:travell_booking_app/presentation/home/home_binding.dart';
import 'package:travell_booking_app/presentation/liberary/library_binding.dart';
import 'package:travell_booking_app/presentation/liberary/library_screen.dart';
import 'package:travell_booking_app/presentation/libraryImageCollection/library_image_collection_binding.dart';
import 'package:travell_booking_app/presentation/libraryImageCollection/library_image_collection_screen.dart';
import '../presentation/auth/reset_password/reset_password_screen.dart';
import '../presentation/dashBoard/dash_board_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => OtpVerificationScreen(),
      binding: OtpVerificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.dashBoard,
      page: () => DashBoardScreen(),
      binding: DashBoardBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addVisit,
      page: () => AddVisitScreen(),
      binding: AddVisitBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.library,
      page: () => LibraryScreen(),
      binding: LibraryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.libraryImageCollection,
      page: () => LibraryImageCollectionScreen(),
      binding: LibraryImageCollectionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addMember,
      page: () => AddMemberInfoScreen(),
      binding: AddMemberInfroBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addClientInformation,
      page: () => AddClientInformation(),
      binding: AddClientInformationBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
