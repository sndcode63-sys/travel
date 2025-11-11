import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../profileCenter/profile_center_controller.dart';
import 'repository_documents_verfication.dart';
import 'package:image/image.dart' as img;

class AssociateVerificationDocController extends GetxController {
  final ProfileCenterController profileController = Get.put(ProfileCenterController());

  // ========================= FILE PICKERS =========================
  Rx<File?> adharFile = Rx<File?>(null);
  RxString adharPrefilled = "".obs;
  RxString adharExt = "".obs;
  RxString adharError = "".obs;
  RxString adharFileName = "".obs;

  Rx<File?> panFile = Rx<File?>(null);
  RxString panPrefilled = "".obs;
  RxString panExt = "".obs;
  RxString panError = "".obs;
  RxString panFileName = "".obs;

  Rx<File?> passportFile = Rx<File?>(null);
  RxString passportPrefilled = "".obs;
  RxString passportExt = "".obs;
  RxString passportError = "".obs;
  RxString passportFileName = "".obs;

  Rx<File?> higherQualificationFile = Rx<File?>(null);
  RxString higherQualificationPrefilled = "".obs;
  RxString higherQualificationExt = "".obs;
  RxString higherQualificationError = "".obs;
  RxString higherQualificationFileName = "".obs;

  Rx<File?> reraFile = Rx<File?>(null);
  RxString reraPrefilled = "".obs;
  RxString reraExt = "".obs;
  RxString reraError = "".obs;
  RxString reraFileName = "".obs;

  Rx<File?> policeFile = Rx<File?>(null);
  RxString policePrefilled = "".obs;
  RxString policeExt = "".obs;
  RxString policeError = "".obs;
  RxString policeFileName = "".obs;

  Rx<File?> bankFile = Rx<File?>(null);
  RxString bankPrefilled = "".obs;
  RxString bankExt = "".obs;
  RxString bankError = "".obs;
  RxString bankFileName = "".obs;

  RxString associateId = "".obs;


  // ========================= USER INPUT FIELDS =========================
  final passportNumberController = TextEditingController();
  final reraCertificateController = TextEditingController();
  final qualificationRemarksController = TextEditingController();
  final policeVerificationController = TextEditingController();
  final adharController = TextEditingController();
  final panController = TextEditingController();
  final bankController = TextEditingController();

  // ========================= LOADING =========================
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    associateId.value= Get.arguments['associate_id'];
    ever(profileController.userData, (_) {
      if (profileController.userData.value.id != null) {
        initDataFromUser();
      }
    });
  }

  void initDataFromUser() {
    final user = profileController.userData.value;

    adharController.text = user.aadharNumber ?? "";
    panController.text = user.panNumber ?? "";
    passportNumberController.text = user.passportNumber ?? "";
    reraCertificateController.text = user.reraCertificate ?? "";
    qualificationRemarksController.text = user.qualificationRemarks ?? "";
    policeVerificationController.text = user.policeVerificationCopy ?? "";
    bankController.text = user.bankCopyDocument ?? "";

    adharPrefilled.value = user.aadharImageSource ?? "";
    panPrefilled.value = user.panImageSource ?? "";
    passportPrefilled.value = user.passportImageSource ?? "";
    higherQualificationPrefilled.value = user.qualificationRemarksImageSource ?? "";
    reraPrefilled.value = user.reraImageSource ?? "";
    policePrefilled.value = user.policeVerificationImageSource ?? "";
    bankPrefilled.value = user.bankCopyImageSource ?? "";

    adharFileName.value = "";
    panFileName.value = "";
    passportFileName.value = "";
    higherQualificationFileName.value = "";
    reraFileName.value = "";
    policeFileName.value = "";
    bankFileName.value = "";
  }

  // ========================= PICK FILE =========================
  Future<void> pickFile(
      Rx<File?> file,
      RxString fileExt,
      RxString error,
      RxString prefilled,
      RxString fileName,
      ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);
      final ext = result.files.single.extension?.toLowerCase() ?? "";
      fileExt.value = ext;

      final fName = result.files.single.name;
      fileName.value = fName;

      final fileSize = await pickedFile.length();
      if (fileSize > 5 * 1024 * 1024) {
        error.value = "File size should be <= 5 MB";
        return;
      } else {
        error.value = "";
      }

      final tempFile = await pickedFile.copy("${Directory.systemTemp.path}/$fName");
      file.value = tempFile;
      prefilled.value = "";
    }
  }

  void clearFile(Rx<File?> file, RxString fileExt, RxString error, RxString prefilled, RxString fileName) {
    file.value = null;
    fileExt.value = "";
    error.value = "";
    prefilled.value = "";
    fileName.value = "";
  }

  Future<String> fileToBase64(File? file, RxString error) async {
    if (file == null) return "";

    final ext = file.path.split('.').last.toLowerCase();
    final bytes = await file.readAsBytes();

    if (['jpg', 'jpeg', 'png'].contains(ext)) {
      img.Image? image = img.decodeImage(bytes);
      if (image == null) {
        error.value = "Failed to decode image";
        return "";
      }
      final resized = img.copyResize(image, width: 800);
      final compressedBytes = img.encodeJpg(resized, quality: 70);
      return base64Encode(compressedBytes);
    } else if (ext == 'pdf') {
      if (file.lengthSync() > 5 * 1024 * 1024) {
        error.value = "PDF size should be <= 5 MB";
        return "";
      }
      return base64Encode(bytes);
    } else {
      error.value = "Unsupported file type";
      return "";
    }
  }

  // ========================= SUBMIT DOCUMENTS =========================
  Future<void> submitDocuments() async {
    try {
      isLoading.value = true;

      final aadharBase64 = await fileToBase64(adharFile.value, adharError);
      final panBase64 = await fileToBase64(panFile.value, panError);
      final passportBase64 = await fileToBase64(passportFile.value, passportError);
      final higherQualificationBase64 = await fileToBase64(higherQualificationFile.value, higherQualificationError);
      final reraBase64 = await fileToBase64(reraFile.value, reraError);
      final policeBase64 = await fileToBase64(policeFile.value, policeError);
      final bankBase64 = await fileToBase64(bankFile.value, bankError);

      final result = await AssociateRepositoryDocumentsVerification.associateUploadDocuments(
        passportNumber: passportNumberController.text.trim(),
        reraCertificate: reraCertificateController.text.trim(),
        qualificationRemarks: qualificationRemarksController.text.trim(),
        policeVerification: policeVerificationController.text.trim(),
        aadharImage: aadharBase64,
        panImage: panBase64,
        passportImage: passportBase64,
        qualificationRemarksImage: higherQualificationBase64,
        reraImage: reraBase64,
        policeVerificationImage: policeBase64,
        bankCopyImage: bankBase64,
        id: associateId.value,

      );

      profileController.userData.update((user) {
        if (user != null) {
          user.aadharNumber = adharController.text.trim();
          user.panNumber = panController.text.trim();
          user.passportNumber = passportNumberController.text.trim();
          user.reraCertificate = reraCertificateController.text.trim();
          user.qualificationRemarks = qualificationRemarksController.text.trim();
          user.policeVerificationCopy = policeVerificationController.text.trim();
          user.bankCopyDocument = bankController.text.trim();

          user.aadharImageSource = adharFile.value?.path ?? adharPrefilled.value;
          user.panImageSource = panFile.value?.path ?? panPrefilled.value;
          user.passportImageSource = passportFile.value?.path ?? passportPrefilled.value;
          user.qualificationRemarksImageSource = higherQualificationFile.value?.path ?? higherQualificationPrefilled.value;
          user.reraImageSource = reraFile.value?.path ?? reraPrefilled.value;
          user.policeVerificationImageSource = policeFile.value?.path ?? policePrefilled.value;
          user.bankCopyImageSource = bankFile.value?.path ?? bankPrefilled.value;
        }
      });

      if (result.status == 200) {
        CustomNotifier.showPopup(
          message: result.message ?? "",
          isSuccess: true,
        );

        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isDialogOpen ?? false) Get.back();
          Get.offAllNamed(
            AppRoutes.associateBank,
            arguments: {'associate_id': associateId.value},
          );        });
      } else {
        CustomNotifier.showPopup(
          message: result.message ?? "",
          isSuccess: false,
        );
      }

    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
