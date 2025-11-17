import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import '../../../models/vehicle/vehicle_list.dart';
import '../updateVehicle/update_vehicle_screen.dart';
import '../vehicleR_controller.dart';
import 'rejected_controller.dart';



class RejectedVehicleScreen extends GetView<RejectedVController> {
  const RejectedVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RejectedVController controller = Get.put(RejectedVController());
    final searchController = Get.find<VehiclerController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(UColors.primary),
                  strokeWidth: 3,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Loading vehicles...",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                SizedBox(height: 16.h),
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          );
        }

        final filteredVehicles = controller.getFilteredVehicles(
          searchController.searchQuery.value,
        );

        if (filteredVehicles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_car_outlined,
                    size: 80,
                    color: Colors.grey[300]
                ),
                SizedBox(height: 16.h),
                Text(
                  searchController.searchQuery.value.isEmpty
                      ? "No Rejected Vehicles Found"
                      : "No matching vehicles",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  searchController.searchQuery.value.isEmpty
                      ? "No rejected vehicles yet"
                      : "Try a different search term",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchUsers(),
          color: UColors.primary,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            itemCount: filteredVehicles.length,
            itemBuilder: (context, index) {
              final vehicle = filteredVehicles[index];
              return AnimatedVehicleCard(
                vehicleList: vehicle,
                controller: controller,
                index: index,
              );
            },
          ),
        );
      }),
    );
  }
}


class AnimatedVehicleCard extends StatefulWidget {
  final VehicleList vehicleList;
  final RejectedVController controller;
  final int index;

  const AnimatedVehicleCard({
    super.key,
    required this.vehicleList,
    required this.controller,
    required this.index,
  });

  @override
  State<AnimatedVehicleCard> createState() => _AnimatedVehicleCardState();
}

class _AnimatedVehicleCardState extends State<AnimatedVehicleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400 + (widget.index * 50)),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: VehicleCard(
          vehicleList: widget.vehicleList,
          controller: widget.controller,
        ),
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final VehicleList vehicleList;
  final RejectedVController controller;

  const VehicleCard({
    super.key,
    required this.vehicleList,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showVehicleDetails(context),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: UColors.primary.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // Image Section with Gradient Overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: _buildVehicleImage(),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                // Status Badge
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: _buildStatusBadge(),
                ),
                // Vehicle Type Badge
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: _buildTypeBadge(),
                ),
              ],
            ),

            // Content Section
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Registration Number
                  Row(
                    children: [
                      Icon(Icons.confirmation_number_outlined,
                        size: 20,
                        color: UColors.primary,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          vehicleList.registrationNumber ?? "N/A",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Vehicle Details Grid
                  _buildDetailRow(
                    Icons.directions_car,
                    "Model",
                    vehicleList.modelName ?? "-",
                  ),
                  SizedBox(height: 8.h),
                  _buildDetailRow(
                    Icons.business,
                    "Brand",
                    vehicleList.brandName ?? "-",
                  ),
                  SizedBox(height: 8.h),
                  _buildDetailRow(
                    Icons.palette,
                    "Color",
                    vehicleList.color ?? "-",
                  ),

                  SizedBox(height: 16.h),
                  Divider(height: 1, color: Colors.grey[200]),
                  SizedBox(height: 16.h),

                  // Action Buttons
                  Row(
                    children: [
                      // Edit Button (only for pending)
                      if ((vehicleList.visitStatus?.toLowerCase() ?? "") == "pending")
                        Expanded(
                          child: _buildEditButton(),
                        ),

                      if ((vehicleList.visitStatus?.toLowerCase() ?? "") == "pending")
                        SizedBox(width: 12.w),

                      // Active/Inactive Switch
                      Expanded(
                        child: _buildActiveSwitch(context),
                      ),

                      SizedBox(width: 12.w),

                      // Delete Button
                      _buildDeleteButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleImage() {
    return Container(
      height: 180.h,
      width: double.infinity,
      color: Colors.grey[200],
      child: (vehicleList.photo != null && vehicleList.photo!.isNotEmpty)
          ? CachedNetworkImage(
        imageUrl: "${vehicleList.fullImageUrl}${vehicleList.photo}",
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(UColors.primary),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(Icons.directions_car, size: 60, color: Colors.grey[400]),
        ),
      )
          : Center(
        child: Icon(Icons.directions_car, size: 80, color: Colors.grey[400]),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: controller.getStatusColor(vehicleList.visitStatus),
        boxShadow: [
          BoxShadow(
            color: controller.getStatusColor(vehicleList.visitStatus).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        vehicleList.visitStatus?.toUpperCase() ?? "N/A",
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTypeBadge() {
    final isTwo = vehicleList.type?.toLowerCase() == '2 wheeler';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isTwo ? UColors.primary : Colors.green,
        boxShadow: [
          BoxShadow(
            color: (isTwo ? UColors.primary : Colors.green).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isTwo ? Icons.two_wheeler : Icons.directions_car,
            size: 14,
            color: Colors.white,
          ),
          SizedBox(width: 4.w),
          Text(
            vehicleList.type ?? "N/A",
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        SizedBox(width: 8.w),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    return GestureDetector(
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
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.green[400]!, Colors.green[600]!],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit, color: Colors.white, size: 18),
            SizedBox(width: 6.w),
            Text(
              "Edit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSwitch(BuildContext context) {
    return Obx(() {
      final isActive = vehicleList.isOn.value;
      return GestureDetector(
        onTap: () => _handleStatusToggle(context, !isActive),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isActive ? Colors.green[50] : Colors.red[50],
            border: Border.all(
              color: isActive ? Colors.green : Colors.red,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isActive ? Icons.check_circle : Icons.cancel,
                color: isActive ? Colors.green : Colors.red,
                size: 20,
              ),
              SizedBox(width: 6.w),
              Text(
                isActive ? "Active" : "Inactive",
                style: TextStyle(
                  color: isActive ? Colors.green[700] : Colors.red[700],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDeleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleDelete(context),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  void _handleStatusToggle(BuildContext context, bool newValue) async {
    bool? confirmChange = await _showConfirmationDialog(
      context: context,
      title: "Change Status",
      message: "Do you want to ${newValue ? 'activate' : 'deactivate'} this vehicle?",
      confirmText: newValue ? "Activate" : "Deactivate",
      confirmColor: newValue ? Colors.green : Colors.red,
      icon: newValue ? Icons.toggle_on : Icons.toggle_off,
      iconColor: newValue ? Colors.green : Colors.red,
    );

    if (confirmChange == true) {
      controller.updateVehicleStatus(vehicleList.id!, newValue);
    }
  }

  void _handleDelete(BuildContext context) async {
    bool? confirmDelete = await _showConfirmationDialog(
      context: context,
      title: "Delete Vehicle",
      message: "Are you sure you want to remove this vehicle? This action cannot be undone.",
      confirmText: "Delete",
      confirmColor: Colors.red,
      icon: Icons.delete_forever_rounded,
      iconColor: Colors.red,
    );

    if (confirmDelete == true) {
      controller.deleteVehicle(vehicleList.id!);
    }
  }

  Future<bool?> _showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required Color confirmColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Confirm",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeOutBack.transform(animation.value);
        return Transform.scale(
          scale: curvedValue,
          child: Opacity(
            opacity: animation.value,
            child: Dialog(
              backgroundColor: Colors.white,
              elevation: 16,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor, size: 48),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.grey[900],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.sp,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: confirmColor,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(
                              confirmText,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
  }

  void _showVehicleDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VehicleDetailsSheet(
        vehicleList: vehicleList,
        controller: controller,
      ),
    );
  }
}

class VehicleDetailsSheet extends StatelessWidget {
  final VehicleList vehicleList;
  final RejectedVController controller;

  const VehicleDetailsSheet({
    super.key,
    required this.vehicleList,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              // Handle Bar
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Vehicle Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: Colors.grey[900],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.grey[600]),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: Colors.grey[200]),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vehicle Image
                      Center(
                        child: Container(
                          height: 250.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: (vehicleList.photo != null && vehicleList.photo!.isNotEmpty)
                                ? CachedNetworkImage(
                              imageUrl: "${vehicleList.fullImageUrl}${vehicleList.photo}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Icons.directions_car, size: 60, color: Colors.grey[400]),
                              ),
                            )
                                : Center(
                              child: Icon(Icons.directions_car, size: 80, color: Colors.grey[400]),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // Details Section
                      _buildDetailCard("Vehicle Information", [
                        _DetailItem("Registration Number", vehicleList.registrationNumber ?? "N/A"),
                        _DetailItem("Type", vehicleList.type ?? "N/A"),
                        _DetailItem("Brand", vehicleList.brandName ?? "N/A"),
                        _DetailItem("Model", vehicleList.modelName ?? "N/A"),
                        _DetailItem("Color", vehicleList.color ?? "N/A"),
                      ]),

                      SizedBox(height: 16.h),

                      _buildDetailCard("Status Information", [
                        _DetailItem("Visit Status", vehicleList.visitStatus ?? "N/A"),
                        _DetailItem("Active Status", vehicleList.active == 1 ? "Active" : "Inactive"),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailCard(String title, List<_DetailItem> items) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: UColors.primary,
            ),
          ),
          SizedBox(height: 12.h),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  child: Text(
                    item.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _DetailItem {
  final String label;
  final String value;
  _DetailItem(this.label, this.value);
}