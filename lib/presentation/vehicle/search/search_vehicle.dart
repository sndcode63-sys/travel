import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_button.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_text_field.dart';
import '../../../utlis/constents/colors.dart';
import '../../../utlis/constents/img_constants.dart';
import 'search_controller.dart';
import '../../../models/vehicle/vehicle_search.dart';

class SearchVehicle extends StatelessWidget {
  SearchVehicle({super.key});

  final SearchVehicleController controller = Get.put(SearchVehicleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Vehicle",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Search vehicle",
                              style: TextStyle(fontSize: 14.sp),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _searchBar(),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    if (!controller.hasSearched.value) {
                      return const SizedBox.shrink();
                    }
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!controller.hasData.value) {
                      return notSearchShow();
                    }
          
                    return ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final vehicle = controller.searchResults[index];
                        return VehicleSearchCard(vehicle: vehicle);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Enter min 3 digits of registration number',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.searchData(controller.searchController.text);
            },
            child: Container(
              decoration: BoxDecoration(
                color: UColors.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child:  Row(
                children: [
                  Text(
                    "Search",
                    style: TextStyle(
                      color: UColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notSearchShow() {
    return Center(
      child: DottedBorder(
        color: Colors.green,
        strokeWidth: 2,
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        padding: EdgeInsets.all(16.w),
        child: Container(
          width: 300.w,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "There is no data to show you right now.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 24.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "BACK TO HOME",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}

class VehicleSearchCard extends StatelessWidget {
  final SearchVehicleController controller =
      Get.find<SearchVehicleController>();

  final VehicleSearch vehicle;

  VehicleSearchCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child:
                      (vehicle.photo != null && vehicle.photo!.isNotEmpty)
                          ? CachedNetworkImage(
                            imageUrl: "${vehicle.fullImageUrl}${vehicle.photo}",
                            fit: BoxFit.cover,
                            width: 60.w,
                            height: 60.h,
                            placeholder:
                                (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Icon(
                                  Icons.directions_car,
                                  size: 30.sp,
                                  color: Colors.grey,
                                ),
                          )
                          : Icon(
                            Icons.directions_car,
                            size: 30.sp,
                            color: Colors.grey,
                          ),
                ),
              ),
              const SizedBox(width: 8),
              Text("Registration No: \n${vehicle.registrationNumber}"),
              Spacer(),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          (vehicle.type?.toLowerCase() == '2 wheeler')
                              ? UColors.primary
                              : Colors.green,
                    ),
                    child: AutoSizeText(
                      vehicle.type ?? "",
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                      minFontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.blue.withOpacity(0.3),
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.95,
                            child: NotifyBottomSheet(vehicleId: vehicle.id!),

                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: UColors.primary,
                      ),
                      child: Text(
                        "Notify",
                        style: TextStyle(
                          color: UColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class NotifyBottomSheet extends StatelessWidget {
  final String vehicleId;
  final SearchVehicleController controller = Get.find<SearchVehicleController>();

  NotifyBottomSheet({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 8,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Notify",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 1, color: UColors.grey),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      "Click Vehicle Picture",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Capture or Preview Image
                  Obx(
                        () => DottedBorder(
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
                          child: controller.capturedImages.value == null
                              ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Image.asset(AppImages.picture, width: 200.w, height: 200.h),
                                SizedBox(height: 8.h),
                                Text(
                                  "Tap to capture vehicle image",
                                  style: TextStyle(
                                    color: UColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              controller.capturedImages.value!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  AppTextField(
                    hintText: "Description",
                    labelText: "Description",
                    controller: controller.descriptionNotify,
                    validator: (value) =>
                    (value == null || value.isEmpty) ? "Enter description" : null,
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      "* Please note that the administration will verify the picture proof attached by you. Any irrelevant picture may attract penalty.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp, color: UColors.black),
                    ),
                  ),
                  const SizedBox(height: 40),

                  CustomButton(
                    text: "NOTIFY",
                    backgroundColor: UColors.primary,
                    onPressed: () => controller.saveForm(vehicleId),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
