import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/img_constants.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';
import 'wigets/home_slider_drawer.dart';

class HomScreen extends StatelessWidget {
  const HomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeSliderDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: Colors.blue.withOpacity(0.5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Builder(
                builder: (context) =>
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                   AppStrings.demoTesting,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "test@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_rounded,
                      color: Colors.white, size: 26),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings,
                      color: Colors.white, size: 26),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),

      // ✅ body wahi rehne diya
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            width: double.infinity,
            child: Image.asset(
              AppImages.banner,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildItem(Icons.group, "Add Visit", Colors.purple, onTap: () {
                  Get.toNamed(AppRoutes.addVisit);
                }),
                _buildItem(Icons.meeting_room, "Add Meeting", Colors.orange),
                _buildItem(Icons.library_books, "Library", Colors.teal,
                    onTap: () {
                      Get.toNamed(AppRoutes.library);
                    }),
                _buildItem(Icons.calendar_month, "Plot", Colors.pink,
                    onTap: () {
                      Get.toNamed(AppRoutes.addMember);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
      IconData icon,
      String title,
      Color color, {
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}







