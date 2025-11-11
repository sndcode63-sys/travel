import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';

import 'verification_doc_controller.dart';

class VerificationDocScreen extends StatelessWidget {
  final VerificationDocController controller = Get.put(VerificationDocController());

  VerificationDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.initDataFromUser();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text("Verification Documents"),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Info Banner
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Upload clear images/PDFs. Max size: 5MB per file',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  FilePickerWidget(
                    label: "Aadhar Card",
                    file: controller.adharFile,
                    prefilledFile: controller.adharPrefilled,
                    fileExt: controller.adharExt,
                    error: controller.adharError,
                    fileName: controller.adharFileName,
                    controller: controller,
                    icon: Icons.credit_card,
                  ),
                  FilePickerWidget(
                    label: "PAN Card",
                    file: controller.panFile,
                    prefilledFile: controller.panPrefilled,
                    fileExt: controller.panExt,
                    error: controller.panError,
                    fileName: controller.panFileName,
                    controller: controller,
                    icon: Icons.badge,
                  ),
                  FilePickerWidget(
                    label: "Passport",
                    file: controller.passportFile,
                    prefilledFile: controller.passportPrefilled,
                    fileExt: controller.passportExt,
                    error: controller.passportError,
                    fileName: controller.passportFileName,
                    controller: controller,
                    icon: Icons.flight_takeoff,
                  ),
                  FilePickerWidget(
                    label: "Higher Qualification",
                    file: controller.higherQualificationFile,
                    prefilledFile: controller.higherQualificationPrefilled,
                    fileExt: controller.higherQualificationExt,
                    error: controller.higherQualificationError,
                    fileName: controller.higherQualificationFileName,
                    controller: controller,
                    icon: Icons.school,
                  ),
                  FilePickerWidget(
                    label: "RERA Certificate",
                    file: controller.reraFile,
                    prefilledFile: controller.reraPrefilled,
                    fileExt: controller.reraExt,
                    error: controller.reraError,
                    fileName: controller.reraFileName,
                    controller: controller,
                    icon: Icons.verified,
                  ),
                  FilePickerWidget(
                    label: "Police Verification",
                    file: controller.policeFile,
                    prefilledFile: controller.policePrefilled,
                    fileExt: controller.policeExt,
                    error: controller.policeError,
                    fileName: controller.policeFileName,
                    controller: controller,
                    icon: Icons.local_police,
                  ),
                  FilePickerWidget(
                    label: "Bank Document",
                    file: controller.bankFile,
                    prefilledFile: controller.bankPrefilled,
                    fileExt: controller.bankExt,
                    error: controller.bankError,
                    fileName: controller.bankFileName,
                    controller: controller,
                    icon: Icons.account_balance,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          // Submit Button (Fixed at bottom)
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Obx(() {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.submitDocuments,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: controller.isLoading.value ? 0 : 3,
                  ),
                  child: controller.isLoading.value
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text("Uploading...", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  )
                      : const Text("SUBMIT DOCUMENTS", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class FilePickerWidget extends StatelessWidget {
  final String label;
  final Rx<File?> file;
  final RxString prefilledFile;
  final RxString fileExt;
  final RxString error;
  final RxString fileName;
  final VerificationDocController controller;
  final IconData icon;

  const FilePickerWidget({
    super.key,
    required this.label,
    required this.file,
    required this.prefilledFile,
    required this.fileExt,
    required this.error,
    required this.fileName,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: UColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: UColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // File Picker Row
            Obx(() {
              final path = file.value?.path ?? prefilledFile.value;

              String displayName;
              if (file.value != null) {
                displayName = fileName.value;
              } else if (prefilledFile.value.isNotEmpty) {
                if (prefilledFile.value.startsWith("data:image")) {
                  displayName = "$label Image";
                } else if (prefilledFile.value.startsWith("data:application/pdf")) {
                  displayName = "$label PDF";
                } else if (prefilledFile.value.startsWith("http")) {
                  displayName = prefilledFile.value.split('/').last;
                } else {
                  displayName = "File Selected";
                }
              } else {
                displayName = "No file chosen";
              }

              return Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => controller.pickFile(file, fileExt, error, prefilledFile, fileName),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.upload_file, size: 18),
                    label: const Text("Choose", style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        displayName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: path.isEmpty ? Colors.grey.shade600 : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  if (path.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _showPreviewDialog(context, path),
                      icon: const Icon(Icons.visibility, color: Colors.blue),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ],
              );
            }),

            const SizedBox(height: 8),

            // Status Message
            Obx(() {
              if (error.value.isNotEmpty) {
                return Row(
                  children: [
                    Icon(Icons.error_outline, size: 16, color: Colors.red),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        error.value,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ],
                );
              } else if (file.value != null || prefilledFile.value.isNotEmpty) {
                return Row(
                  children: [
                    Icon(Icons.check_circle, size: 16, color: Colors.green),
                    const SizedBox(width: 6),
                    const Text(
                      "File selected",
                      style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        "Supported: JPG, PNG, PDF (Max 5MB)",
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  void _showPreviewDialog(BuildContext context, String path) {
    String ext = path.split('.').last.toLowerCase();
    bool isBase64 = path.startsWith("data:");

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: ext == "pdf" ? MediaQuery.of(context).size.height * 0.75 : null,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.95,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: UColors.primary,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Preview - $label",
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: isBase64
                        ? path.startsWith("data:image")
                        ? Image.memory(base64Decode(path.split(',').last), fit: BoxFit.contain)
                        : path.startsWith("data:application/pdf")
                        ? PDFViewFromBase64(base64String: path.split(',').last)
                        : const Center(child: Text("Unsupported file"))
                        : ext == "pdf"
                        ? PDFView(filePath: path)
                        : path.startsWith("http")
                        ? CachedNetworkImage(imageUrl: path, fit: BoxFit.contain)
                        : Image.file(File(path), fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PDFViewFromBase64 extends StatelessWidget {
  final String base64String;
  const PDFViewFromBase64({super.key, required this.base64String});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _writeBase64ToFile(base64String),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text("Failed to load PDF"));
        }
        return PDFView(filePath: snapshot.data!.path);
      },
    );
  }

  Future<File> _writeBase64ToFile(String base64Str) async {
    final bytes = base64Decode(base64Str);
    final file = File('${Directory.systemTemp.path}/temp_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}