import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDemoController extends  GetxController{

  var currentPage = 0.obs;

  void updatePage(int index) {
    currentPage.value = index;
  }
}



class PageViewScreen extends StatelessWidget {
  PageViewScreen({super.key});

  final MyDemoController controller = Get.put(MyDemoController());

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
  ];

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: colors.length,
            onPageChanged: controller.updatePage,
            itemBuilder: (context, index) {
              return Container(
                color: colors[index],
                child: Center(
                  child: Text(
                    "Page ${index + 1}",
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              );
            },
          ),

          // Indicator
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  colors.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: controller.currentPage.value == index ? 25 : 10,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? Colors.white
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
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
