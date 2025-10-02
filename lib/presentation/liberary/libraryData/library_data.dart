import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:video_player/video_player.dart';

import '../../../utlis/custom_widgets/custom_listview_builder.dart';
import 'library_data_controller.dart';

class LibraryDataScreen extends StatelessWidget {
  final LibraryDataController controller = Get.put(LibraryDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Library",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Library List", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.blue.withOpacity(0.08),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Error: ${controller.errorMessage.value}'),
            );
          }

          if (controller.livn.isEmpty) {
            return Center(child: Text('No Data Found'));
          }

          return CustomListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemCount: controller.livn.length,
            itemBuilder: (context, index, item) {
              final headL = controller.livn[index];
              List<String> imageData = headL.images?.split(",") ?? [];
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Project Name: ${headL.schemeName}"),
                            Text("Library Head Name: ${headL.libraryHeadName}"),
                            // Image Row
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // ----------------- Images -----------------
                          if (headL.images != null &&
                              (headL.images!.toLowerCase().endsWith(".jpg") ||
                                  headL.images!.toLowerCase().endsWith(".jpeg") ||
                                  headL.images!.toLowerCase().endsWith(".png")))
                            ...headL.images!.split(",").map((img) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  InteractiveViewer(
                                                    child: CachedNetworkImage(
                                                      imageUrl: "${headL.fullImageUrl}$img",
                                                      fit: BoxFit.contain,
                                                      placeholder: (context, url) =>
                                                      const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) =>
                                                      const Icon(Icons.error, size: 50),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    right: 10,
                                                    child: IconButton(
                                                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                                                      onPressed: () => Navigator.pop(context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                FileDownloader.downloadAndOpen(
                                                  "${headL.fullImageUrl}$img",
                                                  img.split('/').last,
                                                );
                                              },
                                              icon: const Icon(Icons.download),
                                              label: const Text("Download"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: "${headL.fullImageUrl}$img",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              );
                            }).toList(),

                          // ----------------- PDF -----------------
                          if (headL.fullPdfUrl != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 500,
                                            child: PDFView(
                                              filePath: headL.fullPdfUrl,
                                            ),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              FileDownloader.downloadAndOpen(
                                                headL.fullPdfUrl!,
                                                "document.pdf",
                                              );
                                            },
                                            icon: const Icon(Icons.download),
                                            label: const Text("Download PDF"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.red.shade100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
                                      SizedBox(height: 5),
                                      Text("PDF", style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          // ----------------- Video -----------------
                          if (headL.fullVideoUrl != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: Container(
                                        width: double.infinity,
                                        height: 300,
                                        color: Colors.black,
                                        child: VideoPlayerDialog(videoUrl: headL.fullVideoUrl!),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.blue.shade100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.play_circle_fill, size: 40, color: Colors.blue),
                                      SizedBox(height: 5),
                                      Text("Video", style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          // ----------------- Other/Fallback -----------------
                          if (headL.images != null &&
                              !headL.images!.toLowerCase().endsWith(".jpg") &&
                              !headL.images!.toLowerCase().endsWith(".jpeg") &&
                              !headL.images!.toLowerCase().endsWith(".png") &&
                              !headL.images!.toLowerCase().endsWith(".pdf") &&
                              !headL.images!.toLowerCase().endsWith(".mp4") &&
                              !headL.images!.toLowerCase().endsWith(".mov"))
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 200,
                                            color: Colors.orange.shade50,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.insert_drive_file, size: 60, color: Colors.orange),
                                                const SizedBox(height: 10),
                                                Text(
                                                  headL.images!.split("/").last,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              FileDownloader.downloadAndOpen(
                                                "${headL.fullImageUrl}${headL.images!}",
                                                headL.images!.split("/").last,
                                              );
                                            },
                                            icon: const Icon(Icons.download),
                                            label: const Text("Download File"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.orange.shade100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.insert_drive_file, size: 40, color: Colors.orange),
                                      SizedBox(height: 5),
                                      Text("Other", style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                  ],
                ),
              );

            },
          );
        }),
      ),
    );
  }
}

class VideoPlayerDialog extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerDialog({super.key, required this.videoUrl});

  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          autoPlay: true,
          looping: false,
          showControlsOnInitialize: true,
        );
        setState(() {});
      });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.5,
              child: _chewieController != null && _videoController.value.isInitialized
                  ? Chewie(controller: _chewieController!)
                  : const Center(child: CircularProgressIndicator()),
            ),
            // Close button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class FileDownloader {
  static Future<void> downloadAndOpen(String url, String fileName) async {
    try {
      Directory? dir;

      if (Platform.isAndroid) {
        dir = Directory("/storage/emulated/0/Download");
      } else if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      }

      if (!await dir!.exists()) {
        await dir.create(recursive: true);
      }

      String filePath = "${dir.path}/$fileName";

      Dio dio = Dio();
      await dio.download(url, filePath);

      print("✅ File downloaded to: $filePath");

      await OpenFile.open(filePath);
    } catch (e) {
      print("Download error: $e");
    }
  }
}
