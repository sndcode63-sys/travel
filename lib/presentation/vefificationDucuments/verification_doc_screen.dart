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
      appBar: AppBar(title: const Text("Verification Document")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FilePickerWidget(
              label: "Upload Adhar",
              file: controller.adharFile,
              prefilledFile: controller.adharPrefilled,
              fileExt: controller.adharExt,
              error: controller.adharError,
              fileName: controller.adharFileName,
              controller: controller,
            ),
            FilePickerWidget(
              label: "Upload PAN",
              file: controller.panFile,
              prefilledFile: controller.panPrefilled,
              fileExt: controller.panExt,
              error: controller.panError,
              fileName: controller.panFileName,
              controller: controller,
            ),
            FilePickerWidget(
              label: "Upload Passport",
              file: controller.passportFile,
              prefilledFile: controller.passportPrefilled,
              fileExt: controller.passportExt,
              error: controller.passportError,
              fileName: controller.passportFileName,
              controller: controller,
            ),
            FilePickerWidget(
              label: "Upload Higher Qualification",
              file: controller.higherQualificationFile,
              prefilledFile: controller.higherQualificationPrefilled,
              fileExt: controller.higherQualificationExt,
              error: controller.higherQualificationError,
              fileName: controller.higherQualificationFileName,
              controller: controller,
            ),
            FilePickerWidget(
              label: "Upload RERA Certificate",
              file: controller.reraFile,
              prefilledFile: controller.reraPrefilled,
              fileExt: controller.reraExt,
              error: controller.reraError,
              fileName: controller.reraFileName,
              controller: controller,
            ),
            FilePickerWidget(
              label: "Upload Police Verification",
              file: controller.policeFile,
              prefilledFile: controller.policePrefilled,
              fileExt: controller.policeExt,
              error: controller.policeError,
              fileName: controller.policeFileName,
              controller: controller,
            ),
            FilePickerWidget(
              label: "Upload Bank Document",
              file: controller.bankFile,
              prefilledFile: controller.bankPrefilled,
              fileExt: controller.bankExt,
              error: controller.bankError,
              fileName: controller.bankFileName,
              controller: controller,
            ),
            SizedBox(height: 30.h),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.submitDocuments,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                      Text("Please wait...", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  )
                      : const Text("UPDATE", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              );
            }),
          ],
        ),
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

  const FilePickerWidget({
    super.key,
    required this.label,
    required this.file,
    required this.prefilledFile,
    required this.fileExt,
    required this.error,
    required this.fileName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 4)),
            BoxShadow(color: Colors.white, blurRadius: 6, offset: const Offset(-2, -2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final path = file.value?.path ?? prefilledFile.value;

              String displayName;
              if (file.value != null) {
                displayName = fileName.value;
              } else if (prefilledFile.value.isNotEmpty) {
                if (prefilledFile.value.startsWith("data:image")) {
                  displayName = "$label Image Selected";
                } else if (prefilledFile.value.startsWith("data:application/pdf")) {
                  displayName = "$label PDF Selected";
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
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                    ),
                    icon: const Icon(Icons.upload_file, size: 20),
                    label: const Text("Upload", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(displayName, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  if (path.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _showPreviewDialog(context, path),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.remove_red_eye, color: Colors.white),
                      ),
                    ),
                  ],
                ],
              );
            }),
            const SizedBox(height: 8),
            Obx(() {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$label :  ",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                    ),
                    if (error.value.isNotEmpty)
                      TextSpan(
                        text: error.value,
                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.red, fontSize: 14),
                      )
                    else if (file.value != null || prefilledFile.value.isNotEmpty)
                      const TextSpan(
                        text: "File selected",
                        style: TextStyle(fontWeight: FontWeight.normal, color: Colors.green, fontSize: 14),
                      )
                    else
                      const TextSpan(
                        text: "Support only Image/PDF. Max file size 5 MB.",
                        style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 14),
                      ),
                  ],
                ),
              );
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
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: ext == "pdf" ? MediaQuery.of(context).size.height * 0.75 : null,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
              maxWidth: MediaQuery.of(context).size.width * 0.95,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Preview", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
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
                        : Center(child: Text("Unsupported file"))
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
