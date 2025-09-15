import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/addmemberInfo/widgets/location_detection.dart';

class AddMemberInfoController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final clientName = TextEditingController();
  final fatherName = TextEditingController();
  final email = TextEditingController();
  final contactNo = TextEditingController();
  final remark = TextEditingController();

  RxBool isFormValid = false.obs;
  Rx<Position?> currentPosition = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    clientName.addListener(validateForm);
    fatherName.addListener(validateForm);
    email.addListener(validateForm);
    contactNo.addListener(validateForm);
    remark.addListener(validateForm);
    getLocationOnStart();
  }

  // Validation
  void validateForm() {
    final nameRegex = RegExp(r"^[a-zA-Z ]{3,}$");
    final emailRegex =
    RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    final phoneRegex = RegExp(r"^[0-9]{10}$");

    if (!nameRegex.hasMatch(clientName.text.trim())) {
      isFormValid.value = false;
      return;
    }
    if (!nameRegex.hasMatch(fatherName.text.trim())) {
      isFormValid.value = false;
      return;
    }
    if (!emailRegex.hasMatch(email.text.trim())) {
      isFormValid.value = false;
      return;
    }
    if (!phoneRegex.hasMatch(contactNo.text.trim())) {
      isFormValid.value = false;
      return;
    }
    if (remark.text.isNotEmpty && remark.text.length > 200) {
      isFormValid.value = false;
      return;
    }

    isFormValid.value = true;
  }

  // API CALL
  Future<void> getLocationOnStart() async {
    currentPosition.value = await LocationService.getCurrentLocation();
  }

  // CLOSED
  @override
  void onClose() {
    clientName.dispose();
    fatherName.dispose();
    email.dispose();
    contactNo.dispose();
    remark.dispose();
    super.onClose();
  }
}
