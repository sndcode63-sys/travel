import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';
import 'package:travell_booking_app/utlis/constents/uHelper.dart';
import 'wigets/home_slider_drawer.dart';

class HomScreen extends StatelessWidget {
  const HomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Scaffold(
      drawer: HomeSliderDrawer(),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: UColors.primary,
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
              builder:
                  (context) => IconButton(
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
                icon: const Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white, size: 26),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Stack(
          //   children: [
          //     Container(
          //       height: 400,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //           bottomLeft: Radius.circular(20),
          //           bottomRight: Radius.circular(20),
          //         ),
          //         color: UColors.primary,
          //       ),
          //     ),
          //   ],
          // ),
          // Stack(
          //   children: [
          //     Positioned(
          //
          //       bottom: -8,
          //       child: SizedBox(
          //         height: 60,
          //         child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 4, itemBuilder: (context, index) {
          //
          //           return Column(
          //             children: [
          //               Container(height: 40,
          //               width: 40,
          //               color: Colors.red,)
          //             ],
          //           );
          //         }),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
