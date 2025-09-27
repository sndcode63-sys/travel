import 'package:flutter/material.dart';



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'verification_doc_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'verification_doc_controller.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class VerificationDocScreen extends StatelessWidget {
  final VerificationDocController controller = Get.put(VerificationDocController());

  VerificationDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verification Document")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: controller.pickFile,
                    child: const Text("Choose file"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      controller.selectedFile.value != null
                          ? controller.selectedFile.value!.path.split('/').last
                          : "No file chosen",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (controller.selectedFile.value != null)
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        _showPreviewDialog(context);
                      },
                    ),
                ],
              );
            }),
            const SizedBox(height: 8),
            const Text(
              "Support only Image/Pdf Only. Max File Size 1 MB.",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showPreviewDialog(BuildContext context) {
    if (controller.selectedFile.value == null) return;

    final file = controller.selectedFile.value!;
    final ext = controller.fileExtension.value.toLowerCase();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: ext == "pdf"
                  ? MediaQuery.of(context).size.height * 0.75
                  : null,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.63,
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
                        const Text(
                          "Preview",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ext == "pdf"
                          ? PDFView(
                        filePath: file.path,
                        enableSwipe: true,
                        swipeHorizontal: true,
                        autoSpacing: true,
                        pageFling: true,
                      )
                          : StatefulBuilder(
                        builder: (context, setState) {
                          bool isContain = false; // Initially cover
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isContain = !isContain; // toggle
                              });
                            },
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return InteractiveViewer(
                                  panEnabled: true,
                                  minScale: 0.5,
                                  maxScale: 4,
                                  child: Container(
                                    width: constraints.maxWidth,
                                    constraints: BoxConstraints(
                                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        file,
                                        fit: isContain ? BoxFit.contain : BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

