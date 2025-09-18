import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';

import 'widgets/custom_tab_Bar.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Report",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Meeting List", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black54),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          20.h,
          // AppTextField(
          //   prefixIcon: Icon(Icons.search),
          //   suffixIcon: Icon(Icons.mic),
          //   hintText: 'Search by Date/Time/Client Name',
          //   hintStyle: TextStyle(color: UColors.grey,
          //   fontSize: 16,
          //   fontWeight: FontWeight.w400),
          // )
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],

              border: Border.all(color: UColors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search, color: Colors.grey),
                Text(
                  'Search by Date/Time/Client Name',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.mic, color: Colors.grey),
              ],
            ),
          ),
          10.h,
          Expanded(child: CustomTabs()),
        ],
      ),
    );
  }


}

