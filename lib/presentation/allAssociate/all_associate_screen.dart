
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import '../../utlis/constents/colors.dart';
import 'widgets/card_section.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AllAssociateScreen extends StatelessWidget {
  const AllAssociateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAssociate = Get.arguments;
    return Scaffold(
      backgroundColor: UColors.white,
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(70.h),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h,bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                      ),
                      Column(
                        children: [
                          Text(
                            "Associate",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${selectedAssociate?.fullName} DETAILS",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: selectedAssociate == null
            ? const Center(child: Text("No associate data available"))
            : SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 6.w),
          child: Column(
            children: [
              InfoSectionCard(
                title: "General Information",
                infoData: {
                  "Father Name": selectedAssociate.fatherName,
                  "Mother Name": selectedAssociate.motherName,
                  "Email": selectedAssociate.email,
                  "Contact": selectedAssociate.phone2,
                  "Date of Birth": selectedAssociate.dob,
                  "Gender": selectedAssociate.gender,
                  "Nominee Name": selectedAssociate.nomineeName,
                  "Nominee Relation": selectedAssociate.nomineeRelation,
                },
              ),
              SizedBox(height: 8.h),
              InfoSectionCard(
                title: "Address Information",
                infoData: {
                  "Address": selectedAssociate.address,
                  "Pincode": selectedAssociate.pincode,
                  "City": selectedAssociate.city,
                  "State": selectedAssociate.state,
                  "Country": selectedAssociate.country,
                },
              ),
              SizedBox(height: 8.h),
              InfoSectionCard(
                title: "Relation Information",
                infoData: {
                  "Rera Serial": selectedAssociate.reraSerial.toString(),
                  "Rera No.": selectedAssociate.reraNumber,
                  "Team Name": selectedAssociate.teamname,
                  "Pin Name": selectedAssociate.pinname,
                  "Location Name": selectedAssociate.locationname,
                  "Upliner Name": selectedAssociate.uplinerName,
                  "Upliner Rera No.": selectedAssociate.uplinerReraNo,
                },
              ),
              SizedBox(height: 8.h),
              InfoSectionCard(
                title: "Bank Information",
                infoData: {
                  "Bank Name": (selectedAssociate.bankInfo != null &&
                      selectedAssociate.bankInfo!.isNotEmpty)
                      ? selectedAssociate.bankInfo!.first.bankName ?? ""
                      : "",
                  "IFSC Code": (selectedAssociate.bankInfo != null &&
                      selectedAssociate.bankInfo!.isNotEmpty)
                      ? selectedAssociate.bankInfo!.first.ifscCode ?? ""
                      : "",
                  "Account Number": (selectedAssociate.bankInfo != null &&
                      selectedAssociate.bankInfo!.isNotEmpty)
                      ? selectedAssociate.bankInfo!.first.accountNumber ?? ""
                      : "",
                },
              ),
              SizedBox(height: 8.h),
              DocumentPreviewCard(
                title: "Documents Verification",
                baseUrl: selectedAssociate.fullImageUrl,
                documents: {
                  "Aadhar": selectedAssociate.aadharFrontFilename,
                  "PAN": selectedAssociate.panCardFilename,
                  "Passport": selectedAssociate.passportFilename,
                  "RERA": selectedAssociate.reraImage,
                  "Police Verification":
                  selectedAssociate.policeVerificationCopy,
                  "Bank Copy": selectedAssociate.bankCopyDocument,
                  "Qualification": selectedAssociate.marksheetImage,
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}







class DocumentPreviewCard extends StatelessWidget {
  final String title;
  final Map<String, String?> documents;
  final String? baseUrl;

  const DocumentPreviewCard({
    super.key,
    required this.title,
    required this.documents,
    this.baseUrl,
  });

  @override
  Widget build(BuildContext context) {
    final allEmpty = documents.values.every((v) => v == null || v.isEmpty);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: allEmpty
          ? Center(
        child: Text(
          "No documents available",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
            TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: documents.entries.map((entry) {
              final docName = entry.key;
              final path = entry.value;

              if (path == null || path.isEmpty) {
                return const SizedBox();
              }

              final fullPath = path.startsWith('http')
                  ? path
                  : "${baseUrl ?? ''}$path";
              final isPdf = fullPath.toLowerCase().endsWith(".pdf");

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isPdf) {
                        Get.to(() => PdfViewerScreen(pdfPath: fullPath));
                      } else {
                        Get.to(() => ImageViewerScreen(imageUrl: fullPath));
                      }
                    },
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: UColors.grey),
                        color: Colors.grey[100],
                      ),
                      child: isPdf
                          ? const Center(
                        child: Icon(Icons.picture_as_pdf,
                            size: 40, color: Colors.red),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          fullPath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image,
                              size: 36, color: Colors.grey),
                          loadingBuilder:
                              (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator(
                                    strokeWidth: 2));
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: 70.w,
                    child: Text(
                      docName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;
  const ImageViewerScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 4,
            loadingBuilder: (context, event) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white54, size: 80),
            ),
          ),

          // Close button at top-left
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath;
  const PdfViewerScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    final isNetwork = pdfPath.startsWith('http');

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
        backgroundColor: Colors.white,
      ),
      body: isNetwork
          ? FutureBuilder<File>(
        future: _downloadAndCacheFile(pdfPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Failed to load PDF\n${snapshot.error}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            return PDFView(filePath: snapshot.data!.path);
          }
          return const SizedBox();
        },
      )
          : PDFView(filePath: pdfPath),
    );
  }

  // Downloads the file safely and caches it locally
  Future<File> _downloadAndCacheFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/${DateTime.now().millisecondsSinceEpoch}.pdf');
        await file.writeAsBytes(bytes, flush: true);
        return file;
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('PDF download failed: $e');
    }
  }
}
