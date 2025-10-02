import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomPageView {
  /// Builds a network-based PageView slider
  static Widget buildNetwork({
    required List<String> imageUrls,
    List<Color>? bgColors,
    double height = 220,
    double borderRadius = 20,
    bool showDots = false,
    Color dotActiveColor = Colors.redAccent,
    Color dotInactiveColor = Colors.white54,
    BoxFit fit = BoxFit.cover, // allow flexible fit
  }) {
    final PageController pageController = PageController();
    final ValueNotifier<int> currentIndex = ValueNotifier(0);
    int currentPage = 0;

    final List<Color> colors = bgColors ??
        [Colors.orange.shade50, Colors.blue.shade50, Colors.green.shade50];

    // 🔹 Auto-scroll every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageController.hasClients && imageUrls.isNotEmpty) {
        currentPage++;
        if (currentPage >= imageUrls.length) currentPage = 0;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (index) => currentIndex.value = index,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors[index % colors.length],
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius - 4),
                  child: Image.network(
                    imageUrls[index],
                    fit: fit, // <-- BoxFit applied here
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
                if (showDots)
                  Positioned(
                    bottom: 12.h,
                    left: 0,
                    right: 0,
                    child: ValueListenableBuilder<int>(
                      valueListenable: currentIndex,
                      builder: (context, value, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(imageUrls.length, (dotIndex) {
                            final isActive = value == dotIndex;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              height: 8.h,
                              width: isActive ? 18.w : 8.w,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? dotActiveColor
                                    : dotInactiveColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
