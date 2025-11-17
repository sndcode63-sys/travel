import 'package:get/get.dart';
import 'package:travell_booking_app/models/associate/associate_bank_info.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information.dart';
import 'package:travell_booking_app/presentation/addVisit/addVisitForClientInfo/add_client_information_binding.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_binding.dart';
import 'package:travell_booking_app/presentation/addVisit/add_visit_screen.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_info_screen.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_infro_binding.dart';
import 'package:travell_booking_app/presentation/addmetting/add_meeting_binding.dart';
import 'package:travell_booking_app/presentation/addmetting/add_meeting_screen.dart';
import 'package:travell_booking_app/presentation/associate/asscoiateTab/associate_tab.dart';
import 'package:travell_booking_app/presentation/associate/asscoiateTab/associate_tab_binding.dart';
import 'package:travell_booking_app/presentation/associate/assocoiateProfileInfo/associate_profile_info_binding.dart';
import 'package:travell_booking_app/presentation/associate/vefificationDucuments/verification_doc_binding.dart';
import 'package:travell_booking_app/presentation/associate/vefificationDucuments/verification_doc_screen.dart';

import 'package:travell_booking_app/presentation/auth/login/login_binding.dart';
import 'package:travell_booking_app/presentation/auth/login/login_screen.dart';
import 'package:travell_booking_app/presentation/auth/otp/otp_verification_binding.dart';
import 'package:travell_booking_app/presentation/auth/otp/otp_verification_screen.dart';
import 'package:travell_booking_app/presentation/auth/password/forget_password_binding.dart';
import 'package:travell_booking_app/presentation/auth/reset_password/reset_password_binding.dart';
import 'package:travell_booking_app/presentation/bankVerification/bank_verification_binding.dart';
import 'package:travell_booking_app/presentation/complaine/AssociateComplain/associate_complain_binding.dart';
import 'package:travell_booking_app/presentation/complaine/AssociateComplain/associate_complain_screen.dart';
import 'package:travell_booking_app/presentation/complaine/complainDispute/complain_dispute_binding.dart';
import 'package:travell_booking_app/presentation/complaine/complainDispute/complaine_dispute_screen.dart';
import 'package:travell_booking_app/presentation/complaine/coplainDisputeSummary/enter_summary_binding.dart';
import 'package:travell_booking_app/presentation/complaine/coplainDisputeSummary/enter_summary_screen.dart';
import 'package:travell_booking_app/presentation/complaine/disputSummary/dispute_enter_binding.dart';
import 'package:travell_booking_app/presentation/complaine/myComplain/my_complain_binding.dart';
import 'package:travell_booking_app/presentation/complaine/myComplain/my_complain_screen.dart';
import 'package:travell_booking_app/presentation/complaine/myComplain1/my_complain_binding1.dart';
import 'package:travell_booking_app/presentation/dashBoard/dash_board_screen.dart';
import 'package:travell_booking_app/presentation/liberary/libraryData/library_data.dart';
import 'package:travell_booking_app/presentation/liberary/libraryData/library_data_binding.dart';
import 'package:travell_booking_app/presentation/liberary/libraryHead/library_head.dart';
import 'package:travell_booking_app/presentation/liberary/libraryHead/library_head_binding.dart';
import 'package:travell_booking_app/presentation/liberary/library_binding.dart';
import 'package:travell_booking_app/presentation/liberary/library_screen.dart';
import 'package:travell_booking_app/presentation/libraryImageCollection/library_image_collection_binding.dart';
import 'package:travell_booking_app/presentation/libraryImageCollection/library_image_collection_screen.dart';
import 'package:travell_booking_app/presentation/meeting/meeting.dart';
import 'package:travell_booking_app/presentation/myComplaintData/my_complaint_data_binding.dart';
import 'package:travell_booking_app/presentation/myComplaintData/my_complaint_data_screen.dart';
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
import 'package:travell_booking_app/presentation/settings/privacyPolicy/privacy_policy_binding.dart';
import 'package:travell_booking_app/presentation/settings/privacyPolicy/privacy_policy_screen.dart';
import 'package:travell_booking_app/presentation/settings/support/help_support_binding.dart';
import 'package:travell_booking_app/presentation/settings/support/help_support_screen.dart';
import 'package:travell_booking_app/presentation/splash/splash_binding.dart';
import 'package:travell_booking_app/presentation/splash/splash_screen.dart';
import 'package:travell_booking_app/presentation/suggestion/suggestionList/suggestion_list_binding.dart';
import 'package:travell_booking_app/presentation/suggestion/suggestionList/suggestion_list_screen.dart';
import 'package:travell_booking_app/presentation/teams/allDownline/all_downline_binding.dart';
import 'package:travell_booking_app/presentation/teams/allDownline/all_downline_screen.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_downline_binding.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_download_screen.dart';
import 'package:travell_booking_app/presentation/teams/team_binding.dart';
import 'package:travell_booking_app/presentation/teams/team_screen.dart';
import 'package:travell_booking_app/presentation/vefificationDucuments/verification_doc_binding.dart';
import 'package:travell_booking_app/presentation/vehicle/addVehicle/add_vehicle_binding.dart';
import 'package:travell_booking_app/presentation/vehicle/addVehicle/add_vehicle_screen.dart';
import 'package:travell_booking_app/presentation/vehicle/search/search_binding.dart';
import 'package:travell_booking_app/presentation/vehicle/search/search_vehicle.dart';
import 'package:travell_booking_app/presentation/vehicle/updateVehicle/update_vehicle_binding.dart';
import 'package:travell_booking_app/presentation/vehicle/updateVehicle/update_vehicle_screen.dart';
import 'package:travell_booking_app/presentation/vehicle/vehicleList/vehicle_list_screen.dart';
import 'package:travell_booking_app/presentation/verification/adhar/aadhar_verification.dart';
import 'package:travell_booking_app/presentation/verification/adhar/aadhar_verification_binding.dart';
import 'package:travell_booking_app/presentation/verification/email/email_verification.dart';
import 'package:travell_booking_app/presentation/verification/email/email_verification_binding.dart';
import 'package:travell_booking_app/presentation/verification/pan/pan_verification.dart';
import 'package:travell_booking_app/presentation/verification/pan/pan_verification_binding.dart';
import 'package:travell_booking_app/presentation/verification/phone/phone_verification.dart';
import 'package:travell_booking_app/presentation/verification/phone/phone_verification_binding.dart';
import '../presentation/addmetting/visitList/visit_list_binding.dart';
import '../presentation/addmetting/visitList/visit_screen.dart';
import '../presentation/associate/associtaeGeneral/add_associate_binding.dart';
import '../presentation/associate/associtaeGeneral/add_associate_screen.dart';
import '../presentation/associate/associtateList/associate_list.dart';
import '../presentation/associate/associtateList/associate_list_binding.dart';
import '../presentation/associate/assocoiateProfileInfo/associate_profile_info_screen.dart';
import '../presentation/associate/bankVerification/bank_verification.dart';
import '../presentation/associate/bankVerification/bank_verification_binding.dart';
import '../presentation/associate/relationInformation/relation_information_binding.dart';
import '../presentation/associate/relationInformation/relation_information_screen.dart';
import '../presentation/auth/password/forget_password_screen.dart';
import '../presentation/auth/reset_password/reset_password_screen.dart';
import '../presentation/bankVerification/bank_verification.dart';
import '../presentation/complaine/complainWithMe/complain_with_me.dart';
import '../presentation/complaine/complainWithMe/complain_with_me_binding.dart';
import '../presentation/complaine/disputSummary/dispute_enter_summary.dart';
import '../presentation/complaine/myComplain1/my_complain_screen1.dart';
import '../presentation/dashBoard/dash_board_binding.dart';
import '../presentation/meeting/meeting_binding.dart';
import '../presentation/settings/resetPassword/reset_password.dart';
import '../presentation/settings/resetPassword/reset_password_binding.dart';
import '../presentation/suggestion/save_suggestion/suggestion_binding.dart';
import '../presentation/suggestion/save_suggestion/suggestion_save_screen.dart';
import '../presentation/theme/theme_binding.dart';
import '../presentation/theme/theme_screen.dart';
import '../presentation/vefificationDucuments/verification_doc_screen.dart';
import '../presentation/vehicle/vehicleList/vehicle_list_binding.dart';
import '../presentation/vehicle/vehicleR.dart';
import '../presentation/vehicle/vehicleR_binding.dart';
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
    GetPage(
      name: AppRoutes.supportDetails,
      page: () => HelpSupportScreen(),
      binding: HelpSupportBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.libraryHead,
      page: () => LibraryHead(),
      binding: LibraryHeadBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.libraryDataScreen,
      page: () => LibraryDataScreen(),
      binding: LibraryDataBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.passwordChangeScreen,
      page: () => ResetPassword(),
      binding: ResetPasswordBinding1(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => PrivacyPolicyScreen(),
      binding: PrivacyPolicyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.complainDispute,
      page: () => ComplaineDisputeScreen(),
      binding: ComplainDisputeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myComplaint,
      page: () => MyComplainScreen(),
      binding: MyComplainBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.enterSummary,
      page: () => EnterSummaryScreen(),
      binding: EnterSummaryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.vehicleAdd,
      page: () => AddVehicleScreen(),
      binding: AddVehicleBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.vehicleList,
      page: () => VehicleListScreen(),
      binding: VehicleListBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.vehicleR,
      page: () => Vehicler(),
      binding: VehiclerBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.associateSearch,
      page: () => AssociateComplainScreen(),
      binding: AssociateComplainBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.staffSummary,
      page: () => DisputeEnterSummary(),
      binding: DisputeEnterBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.myData,
      page: () => MyComplaintDataScreen(),
      binding: MyComplaintDataBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.theme,
      page: () => ThemeScreen(),
      binding: ThemeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.searchVehicle,
      page: () => SearchVehicle(),
      binding: SearchVehicleBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.updateVehicle,
      page: () => UpdateVehicleScreen(),
      binding: UpdateVehicleBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.saveSuggestion,
      page: () => SuggestionSaveScreen(),
      binding: SuggestionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.suggestionListScreen,
      page: () => SuggestionListScreen(),
      binding: SuggestionListBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.panVerification,
      page: () => PanVerification(),
      binding: PanVerificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.aadharVerification,
      page: () => AadharVerification(),
      binding: AadharVerificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.phoneVerification,
      page: () => PhoneVerification(),
      binding: PhoneVerificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.emailVerification,
      page: () => EmailVerification(),
      binding: EmailVerificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addAssociate,
      page: () => AddAssociateScreen(),
      binding: AddAssociateBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.associateProfile,
      page: () => AssociateProfileInfoScreen(),
      binding: AssociateProfileInfoBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.associateRelationInfo,
      page: () => AssociateRelationInformationScreen(),
      binding: AssociateRelationInformationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.associateVerification,
      page: () => AssociateVerificationDocScreen(),
      binding: AssociateVerificationDocBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.associateBank,
      page: () => AssociateBankVerification(),
      binding: AssociateBankVerificationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.associateList,
      page: () => AssociateList(),
      binding: AssociateListBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.associateTab,
      page: () => AssociateTab(),
      binding: AssociateTabBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.unifiedVerification,
      page: () => AssociateTab(),
      binding: AssociateTabBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myComplain1,
      page: () => MyComplainScreen1(),
      binding: MyComplainBinding1(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myComplainWithMe,
      page: () => ComplainWithMe(),
      binding: ComplainWithMeBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
