import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/custom_widgets/custom_listview_builder.dart';
import '../../../utlis/app_routes.dart';
import 'library_head_controller.dart';
class LibraryHead extends StatelessWidget {
  const LibraryHead({super.key});

  Widget getIconForType(String? type) {
    switch (type?.toLowerCase()) {
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 30);
      case 'image':
        return const Icon(Icons.image, color: Colors.blue, size: 30);
      case 'video':
        return const Icon(Icons.videocam, color: Colors.orange, size: 30);
      case 'ppt':
        return const Icon(Icons.slideshow, color: Colors.deepOrange, size: 30);
      case 'location':
      case 'map':
        return const Icon(Icons.location_on, color: Colors.green, size: 30);
      default:
        return const Icon(Icons.sentiment_satisfied_alt, color: Colors.purple, size: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    final LibraryHeadController controller = Get.put(LibraryHeadController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Library", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                        Text("Library Type", style: TextStyle(fontSize: 14.sp)),
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
          if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
          if (controller.errorMessage.isNotEmpty) return Center(child: Text('Error: ${controller.errorMessage.value}'));
          if (controller.livn.isEmpty) return const Center(child: Text('No Data Found'));

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            itemCount: controller.livn.length,
            itemBuilder: (context, index) {
              final headL = controller.livn[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.libraryDataScreen,
                      arguments: {
                        'schemeId': headL.id,
                        'scheme_name': headL.schemeName,
                        'library_head_name': headL.id,
                      },
                    );
                    print('➡ Selected schemeName: ${headL.schemeName}, libraryHeadName: ${headL.id}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          getIconForType(headL.type),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              headL.name ?? "",
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
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
        }),
      ),
    );
  }
}
