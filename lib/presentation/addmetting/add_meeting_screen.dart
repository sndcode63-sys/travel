import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addmetting/add_meeting_controller.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import '../../utlis/constents/color_constants.dart';
import '../../utlis/custom_widgets/custom_text_field.dart';

class AddMeetingScreen extends StatelessWidget {
  const AddMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMeetingController());

    // Screen open hote hi camera automatically open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.openCamera();
    });

    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Meeting", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                          Text("Add Meeting", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: UColors.greyDark)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(icon: const Icon(Icons.settings, color: Colors.black54), onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.blue.withOpacity(0.08),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      AppTextField(
                        hintText: 'Number Of Users',
                        labelText: 'Number Of Users',
                        controller: controller.numberOfUsersController,
                        validator: controller.validateNumberOfUsers,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20.h),
                      AppTextField(
                        hintText: 'Reference',
                        labelText: 'Reference',
                        controller: controller.referenceController,
                        validator: controller.validateReference,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 30.h),
                      Obx(() => DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 1,
                        dashPattern: const [6, 3],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => controller.openCamera(),
                          child: Container(
                            height: 310.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: controller.capturedImage.value == null
                                ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, color: UColors.primary, size: 40.sp),
                                  SizedBox(height: 8.h),
                                  Text("Tap to capture selfie", style: TextStyle(color: UColors.primary, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(controller.capturedImage.value!, fit: BoxFit.cover, width: double.infinity),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: 25.h),
                      Obx(() => CustomButton(
                        text: 'SAVE',
                        backgroundColor: AppColors.primary,
                        onPressed: () => controller.saveForm(),
                        isLoading: controller.isLoading.value,
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      cameras = await availableCameras();
      // Front camera select
      final frontCamera = cameras!.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => cameras!.first);

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      if (!mounted) return;
      setState(() {
        isInitialized = true;
      });
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final XFile file = await _controller!.takePicture();
      Get.back(result: File(file.path)); // Return the captured file
    } catch (e) {
      debugPrint("Capture error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _captureImage,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

