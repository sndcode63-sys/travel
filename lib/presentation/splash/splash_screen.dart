import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'spalsh_controller.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => AnimatedScale(
              scale: controller.scale.value,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              child: Icon(
                Icons.flutter_dash,
                size: 100,
                color: Colors.white,
              ),
            )),

            const SizedBox(height: 20),

            Obx(() => AnimatedOpacity(
              opacity: controller.opacity.value,
              duration: Duration(milliseconds: 800),
              child: Text(
                "Demo App",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
