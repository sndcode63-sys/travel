import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:get/get.dart';

class RelationInformationController extends GetxController{

  RxString selectedTeam = "".obs;
  RxString selectedRera = "".obs;
  final selectedTeams = SingleValueDropDownController();
  final selectedR = SingleValueDropDownController();

}