import 'package:travell_booking_app/models/profiles/documents_verification_model.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';


class RepositoryDocumentsVerification {
  static final _apiServices = ApiServices();

  static Future<DocumentsVerificationModel> uploadDocuments({
    required String passportNumber,
    required String reraCertificate,
    required String qualificationRemarks,
    required String policeVerification,
    required String aadharImage,
    required String panImage,
    required String passportImage,
    required String qualificationRemarksImage,
    required String reraImage,
    required String policeVerificationImage,
    required String bankCopyImage,
  }) async {
    return await _apiServices.post<DocumentsVerificationModel>(
      ApiConstants1.updateAssociateProfile,
          (json) => DocumentsVerificationModel.fromJson(json),
      data: {
        "actiontype": "verification-information",
        "passport_number": passportNumber,
        "rera_certificate": reraCertificate,
        "qualification_remarks": qualificationRemarks,
        "police_verification": policeVerification,
        "aadhar_image": aadharImage,
        "pan_image": panImage,
        "passport_image": passportImage,
        "qualification_remarks_image": qualificationRemarksImage,
        "rera_image": reraImage,
        "police_verification_image": policeVerificationImage,
        "bank_copy_image": bankCopyImage,
      },
    );
  }
}
