import 'package:get/get.dart';

import 'package:get/get.dart';

import 'package:get/get.dart';

class GeneralInformationController extends GetxController {
  // Text field controllers
  final fullName = ''.obs;
  final fatherName = ''.obs;
  final motherName = ''.obs;
  final spouseName = ''.obs;
  final email = ''.obs;
  final contactNumber = ''.obs;
  final gender = ''.obs;
  final nomineeName = ''.obs;
  final nomineeRelation = ''.obs;

  // Date of Birth
  RxInt selectedDay = 1.obs;
  RxInt selectedMonth = 1.obs;
  RxInt selectedYear = 2000.obs;

  // Lists for dropdown
  List<int> days = List.generate(31, (index) => index + 1);
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(
      DateTime.now().year - 1900 + 1, (index) => 1900 + index);

  DateTime get selectedDate =>
      DateTime(selectedYear.value, selectedMonth.value, selectedDay.value);

  // Computed property to check if required fields are filled
  bool get isFormValid =>
      fullName.value.trim().isNotEmpty &&
          fatherName.value.trim().isNotEmpty &&
          email.value.trim().isNotEmpty &&
          contactNumber.value.trim().isNotEmpty &&
          gender.value.trim().isNotEmpty;
}
