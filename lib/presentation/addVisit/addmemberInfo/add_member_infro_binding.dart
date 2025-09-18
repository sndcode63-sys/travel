import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/add_member_info_controller.dart';

class AddMemberInfroBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddMemberInfoController>(() => AddMemberInfoController());
  }
}