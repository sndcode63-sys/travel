import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import '../../../models/vehicle/vehicle_list.dart';
import '../updateVehicle/update_vehicle_screen.dart';
import 'vehicle_controller.dart';

class VehicleListScreen extends GetView<VehicleController> {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VehicleController controller = Get.put(VehicleController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(child: Text(controller.errorMessage.value));
        }
        if (controller.allMeeting.isEmpty) {
          return const Center(child: Text("No Vehicles Found"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchUsers(),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: controller.allMeeting.length,
            itemBuilder: (context, index) {
              final vehicle = controller.allMeeting[index];
              return VehicleCard(vehicleList: vehicle, controller: controller);
            },
          ),
        );
      }),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final VehicleList vehicleList;
  final VehicleController controller;
  const VehicleCard({
    super.key,
    required this.vehicleList,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.blue.withOpacity(0.3),
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.95,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Vehicle Information",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(height: 0, thickness: 1, color: UColors.grey),
                        const SizedBox(height: 12),
                        Center(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: UColors.grey),
                            ),
                            child: Container(
                              width: 70.w,
                              height: Get.width * 0.8.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: UColors.grey),
                                color: Colors.grey[200],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child:
                                    (vehicleList.photo != null &&
                                            vehicleList.photo!.isNotEmpty)
                                        ? CachedNetworkImage(
                                          imageUrl:
                                              "${vehicleList.fullImageUrl}${vehicleList.photo}",
                                          fit: BoxFit.cover,
                                          placeholder:
                                              (context, url) => const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Center(
                                                    child: Icon(
                                                      Icons.directions_car,
                                                      size: 40,
                                                    ),
                                                  ),
                                        )
                                        : Center(
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.grey[400],
                                            child: const Icon(
                                              Icons.directions_car,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Divider(height: 0, thickness: 1, color: UColors.grey),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Submit Data"),
                                  Text("N/A"),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vehicle TYpe"),
                                  Text(vehicleList.type ?? ""),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Text("Brand"),
                                  Text(vehicleList.brandName ?? "")],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Model Name"),
                                  Text(vehicleList.modelName ?? ""),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Registration Number"),
                                  Text(vehicleList.registrationNumber ?? ""),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Color"),
                                  Text(vehicleList.color ?? ""),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Status"),
                                  Container(
                                    height: 24.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: controller.getStatusColor(vehicleList.visitStatus).withAlpha(40),
                                    ),
                                    child: Center(
                                      child: Text(
                                        vehicleList.visitStatus ?? "",
                                        style: TextStyle(
                                          color: controller.getStatusColor(vehicleList.visitStatus),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: UColors.grey),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        (vehicleList.photo != null &&
                                vehicleList.photo!.isNotEmpty)
                            ? CachedNetworkImage(
                              imageUrl:
                                  "${vehicleList.fullImageUrl}${vehicleList.photo}",
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => const Center(
                                    child: Icon(Icons.directions_car, size: 40),
                                  ),
                            )
                            : Center(
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[400],
                                child: const Icon(
                                  Icons.directions_car,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                  ),
                ),

                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Registration: ${vehicleList.registrationNumber ?? "-"}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  (vehicleList.type?.toLowerCase() ==
                                          '2 wheeler')
                                      ? UColors.primary
                                      : Colors.green,
                            ),
                            child: Text(
                              vehicleList.type ?? "",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Model: ${vehicleList.modelName ?? "-"}",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Brand: ${vehicleList.brandName ?? "-"}",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Color: ${vehicleList.color ?? "-"}",
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 24.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller
                              .getStatusColor(vehicleList.visitStatus)
                              .withAlpha(40),
                        ),
                        child: Center(
                          child: Text(
                            vehicleList.visitStatus ?? "",
                            style: TextStyle(
                              color: controller.getStatusColor(
                                vehicleList.visitStatus,
                              ),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if ((vehicleList.visitStatus?.toLowerCase() ?? "") ==
                        "pending")
                      GestureDetector(
                        onTap: () async {
                          final result = await Get.to(
                            () => UpdateVehicleScreen(),
                            arguments: vehicleList,
                          );
                          if (result == true) {
                            controller.fetchUsers();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.greenAccent,
                          ),
                          child: const Text(
                            "Edit Details",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    SizedBox(width: 8.w),
                    Obx(
                      () => Switch(
                        value: vehicleList.isOn.value,
                        onChanged: (value) async {
                          bool? confirmChange = await showGeneralDialog<bool>(
                            context: Get.context!,
                            barrierDismissible: true,
                            barrierLabel: "Confirm",
                            barrierColor: Colors.black54, // dim background
                            transitionDuration: const Duration(
                              milliseconds: 300,
                            ), // smooth animation
                            pageBuilder: (context, animation1, animation2) {
                              return const SizedBox.shrink(); // required by showGeneralDialog
                            },
                            transitionBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              final curvedValue =
                                  Curves.easeInOutBack.transform(
                                    animation.value,
                                  ) -
                                  1.0;

                              return Transform.scale(
                                scale: 1 + curvedValue * 0.05, // pop-in effect
                                child: Opacity(
                                  opacity: animation.value,
                                  child: Dialog(
                                    backgroundColor: Colors.white,
                                    elevation: 12,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(22.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Animated icon
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 400,
                                            ),
                                            curve: Curves.easeInOut,
                                            decoration: BoxDecoration(
                                              color:
                                                  value
                                                      ? Colors.green
                                                          .withOpacity(0.15)
                                                      : Colors.red.withOpacity(
                                                        0.15,
                                                      ),
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(20),
                                            child: Icon(
                                              value
                                                  ? Icons.toggle_on
                                                  : Icons.toggle_off,
                                              color:
                                                  value
                                                      ? Colors.green
                                                      : Colors.red,
                                              size: 60,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            "Are you sure?",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Do you want to ${value ? 'activate' : 'deactivate'} this vehicle?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 25),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // Cancel Button
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  foregroundColor: Colors.black,
                                                  elevation: 0,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 10,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                ),
                                                onPressed:
                                                    () => Navigator.pop(
                                                      context,
                                                      false,
                                                    ),
                                                child: const Text("Cancel"),
                                              ),
                                              // Confirm Button
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      value
                                                          ? Colors.green
                                                          : Colors.red,
                                                  foregroundColor: Colors.white,
                                                  elevation: 3,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 10,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                ),
                                                onPressed:
                                                    () => Navigator.pop(
                                                      context,
                                                      true,
                                                    ),
                                                child: Text(
                                                  value
                                                      ? "Activate"
                                                      : "Deactivate",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                          if (confirmChange == true) {
                            controller.updateVehicleStatus(
                              vehicleList.id!,
                              value,
                            );
                          }
                        },
                        activeColor: UColors.primary,
                        inactiveThumbColor: UColors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: InkWell(
                    onTap: () async {
                      bool? confirmDelete = await showGeneralDialog<bool>(
                        context: Get.context!,
                        barrierDismissible: true,
                        barrierLabel: "DeleteConfirm",
                        barrierColor: Colors.black54,
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation1, animation2) {
                          return const SizedBox.shrink();
                        },
                        transitionBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          final curvedValue =
                              Curves.easeInOutBack.transform(animation.value) -
                              1.0;

                          return Transform.scale(
                            scale: 1 + curvedValue * 0.05,
                            child: Opacity(
                              opacity: animation.value,
                              child: Dialog(
                                backgroundColor: Theme.of(context).cardColor,
                                elevation: 12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(22.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 400,
                                        ),
                                        curve: Curves.easeInOut,
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(20),
                                        child: const Icon(
                                          Icons.delete_forever_rounded,
                                          color: Colors.red,
                                          size: 60,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "Are you sure?",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Do you want to remove this vehicle?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey[200],
                                              foregroundColor: Colors.black,
                                              elevation: 0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 10,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed:
                                                () => Navigator.pop(
                                                  context,
                                                  false,
                                                ),
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              elevation: 3,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 10,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed:
                                                () => Navigator.pop(
                                                  context,
                                                  true,
                                                ),
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );

                      if (confirmDelete == true) {
                        controller.deleteVehicle(vehicleList.id!);
                      }
                    },
                    child: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
