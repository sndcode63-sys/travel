import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';

import 'slider_drawer_helper.dart';

class HomeSliderDrawer extends StatelessWidget {
  const HomeSliderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            // 🔹 Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
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
                  SizedBox(height: 5),
                  Text(
                    "test@gmail.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Profile/Action Card
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withAlpha(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade700,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Menu Items
            DrawerMenuItem(
              icon: Icons.person,
              label: "Add Visit",
              onTap: () {},
            ),
            DrawerMenuItem(
              icon: Icons.meeting_room,
              label: "Add Meeting",
              onTap: () {},
            ),
            DrawerMenuItem(icon: Icons.group, label: "Team", onTap: () {}),
            DrawerMenuItem(
              icon: Icons.settings,
              label: "Setting",
              onTap: () {},
            ),
            DrawerMenuItem(
              icon: Icons.help,
              label: "Help & Support",
              onTap: () {},
            ),
            DrawerMenuItem(
              icon: Icons.campaign,
              label: "Notice Board",
              onTap: () {},
            ),
            DrawerMenuItem(icon: Icons.book, label: "Report", onTap: () {}),
            DrawerMenuItem(
              icon: Icons.phone_android,
              label: "App Settings",
              onTap: () {},
            ),
            DrawerMenuItem(icon: Icons.logout, label: "Logout", onTap: () {}),

            const Divider(height: 30, thickness: 1, color: Colors.white30),

            // 🔹 Footer Section
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: const [
                  Text(
                    "Designed & Developed by",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Glitchprobe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Version: 1.1.1",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

