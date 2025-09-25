import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information_binding.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_binding.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_screen.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_info_screen.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_infro_binding.dart';
import 'package:travell_booking_app/presentation/addmetting/add_meeting_binding.dart';
import 'package:travell_booking_app/presentation/addmetting/add_meeting_screen.dart';
import 'package:travell_booking_app/presentation/auth/login/login_binding.dart';
import 'package:travell_booking_app/presentation/auth/login/login_screen.dart';
import 'package:travell_booking_app/presentation/auth/otp/otp_verification_binding.dart';
import 'package:travell_booking_app/presentation/auth/otp/otp_verification_screen.dart';
import 'package:travell_booking_app/presentation/auth/password/forget_password_binding.dart';
import 'package:travell_booking_app/presentation/auth/reset_password/reset_password_binding.dart';
import 'package:travell_booking_app/bottom_navigation_bar.dart';
import 'package:travell_booking_app/presentation/bankVerification/bank_verification_binding.dart';
import 'package:travell_booking_app/presentation/dashBoard/dash_board_screen.dart';
import 'package:travell_booking_app/presentation/home/home_binding.dart';
import 'package:travell_booking_app/presentation/liberary/library_binding.dart';
import 'package:travell_booking_app/presentation/liberary/library_screen.dart';
import 'package:travell_booking_app/presentation/libraryImageCollection/library_image_collection_binding.dart';
import 'package:travell_booking_app/presentation/libraryImageCollection/library_image_collection_screen.dart';
import 'package:travell_booking_app/presentation/meeting/meeting.dart';
import 'package:travell_booking_app/presentation/profileCenter/picProfile/profile_pic_binding.dart';
import 'package:travell_booking_app/presentation/profileCenter/picProfile/profile_pic_screen.dart';
import 'package:travell_booking_app/presentation/profileCenter/profileInfo/profile_info_binding.dart';
import 'package:travell_booking_app/presentation/profileCenter/profileInfo/profile_info_screen.dart';
import 'package:travell_booking_app/presentation/profileCenter/profile_center_binding.dart';
import 'package:travell_booking_app/presentation/profileCenter/profile_center_screen.dart';
import 'package:travell_booking_app/presentation/profileCenter/profilgeneral/general_information.dart';
import 'package:travell_booking_app/presentation/profileCenter/profilgeneral/general_information_binding.dart';
import 'package:travell_booking_app/presentation/relationInformation/relation_information_binding.dart';
import 'package:travell_booking_app/presentation/relationInformation/relation_information_screen.dart';
import 'package:travell_booking_app/presentation/splash/splash_binding.dart';
import 'package:travell_booking_app/presentation/splash/splash_screen.dart';
import 'package:travell_booking_app/presentation/teams/allDownline/all_downline_binding.dart';
import 'package:travell_booking_app/presentation/teams/allDownline/all_downline_screen.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_downline_binding.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_download_screen.dart';
import 'package:travell_booking_app/presentation/teams/team_binding.dart';
import 'package:travell_booking_app/presentation/teams/team_screen.dart';
import 'package:travell_booking_app/presentation/vefificationDucuments/verification_doc_binding.dart';
import '../presentation/addmetting/visitList/visit_list_binding.dart';
import '../presentation/addmetting/visitList/visit_screen.dart';
import '../presentation/auth/password/forget_password_screen.dart';
import '../presentation/auth/reset_password/reset_password_screen.dart';
import '../presentation/bankVerification/bank_verification.dart';
import '../presentation/dashBoard/dash_board_binding.dart';
import '../presentation/meeting/meeting_binding.dart';
import '../presentation/vefificationDucuments/verification_doc_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
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
    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => HomeScreen(),
    //   binding: HomeBinding(),
    //   transition: Transition.rightToLeft,
    // ),
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
    GetPage(
      name: AppRoutes.meetingList,
      page: () => Meeting(),
      binding: MeetingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.teamScreen,
      page: () => TeamScreen(),
      binding: TeamBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.selfDownline,
      page: () => SelfDownloadScreen(),
      binding: SelfDownlineBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.meeting,
      page: () => Meeting(),
      binding: MeetingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.visitList,
      page: () => VisitScreen(),
      binding: VisitListBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.allDowline,
      page: () => AllDownlineScreen(),
      binding: AllDownlineBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addMeeting,
      page: () => AddMeetingScreen(),
      binding: AddMeetingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profileCenter,
      page: () => ProfileCenterScreen(),
      binding: ProfileCenterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.generalInformation,
      page: () => GeneralInformation(),
      binding: GeneralInformationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profilePic,
      page: () => ProfilePicScreen(),
      binding: ProfilePicBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profileInfo,
      page: () => ProfileInfoScreen(),
      binding: ProfileInfoBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.verificationDocuments,
      page: () => VerificationDocScreen(),
      binding: VerificationDocBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.relationInfo,
      page: () => RelationInformationScreen(),
      binding: RelationInformationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.bankInfo,
      page: () => BankVerification(),
      binding: BankVerificationBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
