// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../constents/img_constants.dart';
//
// class MyCustom {
//   MyCustom._(); // 🔒 Prevent instantiation
//
//   // ------------------ 🔹 AppBar ------------------
//   static AppBar buildAppBar() {
//     return AppBar(
//       leadingWidth: 35,
//       leading: IconButton(
//         onPressed: () {},
//         icon: const Icon(Icons.arrow_back, color: Colors.black),
//       ),
//       title: const Text("Demo By Sonu"),
//       centerTitle: true,
//     );
//   }
//
//   // ------------------ 🔹 PageView ------------------
//   static Widget buildPageView({bool showDots = false}) {
//     final PageController pageController = PageController();
//     final ValueNotifier<int> currentIndex = ValueNotifier(0);
//     int currentPage = 0;
//
//     final List<String> banners = [
//       AppImages.banner1,
//       AppImages.banner1,
//       AppImages.banner1,
//       AppImages.banner1,
//     ];
//
//     final List<Color> bgColors = [
//       Colors.orange.shade50,
//       Colors.blue.shade50,
//       Colors.green.shade50,
//       Colors.purple.shade50,
//     ];
//
//     // 🔹 Auto-scroll
//     Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (pageController.hasClients) {
//         currentPage++;
//         if (currentPage >= banners.length) {
//           currentPage = 0;
//         }
//         pageController.animateToPage(
//           currentPage,
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//
//     return SizedBox(
//       height: 220,
//       child: PageView.builder(
//         controller: pageController,
//         onPageChanged: (index) => currentIndex.value = index,
//         itemCount: banners.length,
//         itemBuilder: (context, index) {
//           return Container(
//             width: Get.width,
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: bgColors[index % bgColors.length],
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image.asset(
//                     banners[index],
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//                 if (showDots)
//                   Positioned(
//                     bottom: 12,
//                     left: 0,
//                     right: 0,
//                     child: ValueListenableBuilder<int>(
//                       valueListenable: currentIndex,
//                       builder: (context, value, _) {
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(banners.length, (dotIndex) {
//                             final isActive = value == dotIndex;
//                             return AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               margin:
//                               const EdgeInsets.symmetric(horizontal: 3),
//                               height: 8,
//                               width: isActive ? 18 : 8,
//                               decoration: BoxDecoration(
//                                 color: isActive
//                                     ? Colors.redAccent
//                                     : Colors.white.withOpacity(0.5),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             );
//                           }),
//                         );
//                       },
//                     ),
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // ------------------ 🔹 Section Title ------------------
//   static Widget buildSectionTitle(
//       String title1, String title2, Color color1, Color color2) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: RichText(
//         text: TextSpan(
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.bold, color: color1),
//           children: [
//             TextSpan(text: title1),
//             TextSpan(text: title2, style: TextStyle(color: color2)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ------------------ 🔹 GridView ------------------
//   static Widget buildGridView() {
//     return GridView.count(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       crossAxisCount: 2,
//       childAspectRatio: 1,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       padding: const EdgeInsets.all(16),
//       children: List.generate(4, (index) {
//         return Card(
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12)),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Text(
//                 "Service ${index + 1}",
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontWeight: FontWeight.w500),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   // ------------------ 🔹 Horizontal List ------------------
//   static Widget buildHorizontalList(
//       int itemCount, double width, double height, Color color) {
//     return SizedBox(
//       height: height,
//       child: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         physics: const BouncingScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//         itemCount: itemCount,
//         itemBuilder: (context, index) {
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             width: width,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12), color: color),
//           );
//         },
//       ),
//     );
//   }
//
//   // ------------------ 🔹 Process Steps ------------------
//   static Widget buildProcessSteps(int stepCount) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         children: List.generate(stepCount, (index) {
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 6),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.orange.shade100,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text("Step ${index + 1}"),
//           );
//         }),
//       ),
//     );
//   }
//
//   // ------------------ 🔹 Action Buttons ------------------
//   static Widget buildActionButtons() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12))),
//             onPressed: () {},
//             child: const Text("Contact"),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12))),
//             onPressed: () {},
//             child: const Text("Free Consultation"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ------------------ 🔹 Custom TabBar (Full Scaffold) ------------------
//   static Widget buildCustomTabBar() {
//     final List<String> titles = ["Home", "Profile", "Settings", "Chat"];
//     final List<IconData> icons = [
//       Icons.dashBoard,
//       Icons.person,
//       Icons.settings,
//       Icons.chat
//     ];
//     final List<Widget> screens = [
//       const Center(child: Text("Home Screen")),
//       const Center(child: Text("Profile Screen")),
//       const Center(child: Text("Settings Screen")),
//       const Center(child: Text("Chat Screen")),
//     ];
//
//     return DefaultTabController(
//       length: titles.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Custom TabBar"),
//           bottom: TabBar(
//             isScrollable: true,
//             indicatorColor: Colors.orange,
//             labelStyle:
//             const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//             tabs: List.generate(
//               titles.length,
//                   (index) => Tab(text: titles[index], icon: Icon(icons[index])),
//             ),
//           ),
//         ),
//         body: TabBarView(
//           children: List.generate(screens.length, (index) => screens[index]),
//         ),
//       ),
//     );
//   }
//
//   // ------------------ 🔹 TabBar Core ------------------
//   static Widget customTabBarCore({
//     required List<String> tabs,
//     required int selectedIndex,
//     required Function(int) onTap,
//     double height = 50,
//     Color selectedColor = Colors.orange,
//     Color unselectedColor = Colors.grey,
//     Color indicatorColor = Colors.orange,
//   }) {
//     return SizedBox(
//       height: height,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: tabs.length,
//         itemBuilder: (context, index) {
//           final bool isSelected = selectedIndex == index;
//           return GestureDetector(
//             onTap: () => onTap(index),
//             child: Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(24),
//                 color: isSelected
//                     ? selectedColor.withOpacity(0.15)
//                     : Colors.transparent,
//                 border: Border.all(
//                   color: isSelected ? indicatorColor : unselectedColor,
//                   width: 1.5,
//                 ),
//               ),
//               child: Text(
//                 tabs[index],
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: isSelected ? selectedColor : unselectedColor,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // ------------------ 🔹 Public Custom TabBar ------------------
//   static Widget customTabBar() {
//     final List<String> defaultTabs = [
//       "Home",
//       "Profile",
//       "Settings",
//       "Chat",
//       "Chat",
//       "Chat",
//     ];
//     int selectedIndex = 0;
//
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return Column(
//           children: [
//             customTabBarCore(
//               tabs: defaultTabs,
//               selectedIndex: selectedIndex,
//               onTap: (index) {
//                 setState(() => selectedIndex = index);
//               },
//             ),
//             Expanded(
//               child: IndexedStack(
//                 index: selectedIndex,
//                 children: [
//                   Container(color: Colors.red),
//                   Container(color: Colors.purple),
//                   Container(color: Colors.yellow),
//                   Container(color: Colors.red),
//                   Container(color: Colors.red),
//                   Container(color: Colors.red),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
