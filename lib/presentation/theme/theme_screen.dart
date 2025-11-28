// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../main.dart';
// import 'theme_controller.dart';
// import 'theme_helper.dart';
//
// class ThemeScreen extends StatelessWidget {
//   ThemeScreen({super.key});
//   final ThemeController themeController = Get.find();
//
//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: ThemeHelper.bottomSheetBackground,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           height: 200,
//           padding: const EdgeInsets.all(16),
//           child: Center(
//             child: Text(
//               "Bottom Sheet",
//               style: TextStyle(
//                 color: ThemeHelper.textColors,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         backgroundColor: ThemeHelper.scaffoldBackground,
//         appBar: AppBar(
//           backgroundColor: themeController.primaryColor.value,
//           title: Text(
//             "Theme Selector Demo",
//             style: TextStyle(color: ThemeHelper.textColors),
//           ),
//           actions: [
//             PopupMenuButton<String>(
//               icon: const Icon(Icons.more_vert),
//               onSelected: (value) {
//                 if (value == 'light') {
//                   themeController.setLightMode();
//                 } else if (value == 'dark') {
//                   themeController.setDarkMode();
//                 } else {
//                   // themeController.setSystemDefault();
//                 }
//               },
//               itemBuilder: (context) => [
//                 const PopupMenuItem(value: 'system', child: Text("System Default")),
//                 const PopupMenuItem(value: 'light', child: Text("Light Mode")),
//                 const PopupMenuItem(value: 'dark', child: Text("Dark Mode")),
//               ],
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: ThemeHelper.fabColor,
//           onPressed: () => _showBottomSheet(context),
//           child: const Icon(Icons.add),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 "Select App Color Theme:",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: ThemeHelper.textColors,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 80,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: themeController.colorThemes.length,
//                   itemBuilder: (context, index) {
//                     final theme = themeController.colorThemes[index];
//                     final isSelected = themeController.selectedThemeIndex.value == index;
//
//                     final colors = theme["colors"]!;
//
//                     return GestureDetector(
//                       onTap: () => themeController.changeTheme(index),
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         width: 60,
//                         height: 60,
//                         margin: const EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: colors,
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: isSelected ? Colors.white : Colors.black54,
//                             width: isSelected ? 3 : 1.5,
//                           ),
//                           boxShadow: isSelected
//                               ? [
//                             BoxShadow(
//                               color: colors.first.withOpacity(0.5),
//                               blurRadius: 8,
//                               spreadRadius: 2,
//                             )
//                           ]
//                               : [],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: themeController.primaryColor.value,
//                   foregroundColor: themeController.secondaryColor.value,
//                 ),
//                 onPressed: () => _showBottomSheet(context),
//                 child:  Text("Show Bottom Sheet",style: TextStyle(color: ThemeHelper.textColors),),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       height: 100,
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       decoration: BoxDecoration(
//                         color: ThemeHelper.containerBackground,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Container ${index + 1}",
//                           style: TextStyle(color: ThemeHelper.textColors),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
//
// class ThemedContainer extends StatelessWidget {
//   final Widget? child;
//   final double? height;
//   final double? width;
//   final EdgeInsetsGeometry? margin;
//   final BorderRadius? borderRadius;
//
//   ThemedContainer({
//     super.key,
//     this.child,
//     this.height,
//     this.width,
//     this.margin,
//     this.borderRadius,
//   });
//
//   final ThemeController themeController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final isDark = themeController.isDark.value;
//       final bgColor = themeController.selectedThemeIndex.value != -1
//           ? themeController.primaryColor.value
//           : (isDark ? Colors.grey[800]! : Colors.grey[300]!);
//
//       return Container(
//         height: height ?? 100,
//         width: width,
//         margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: borderRadius ?? BorderRadius.circular(12),
//         ),
//         child: child,
//       );
//     });
//   }
// }
