import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';

class ComplaineDisputeScreen extends StatelessWidget {
  const ComplaineDisputeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
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
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    Text(
                      "Complaint/Dispute",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_rounded),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Center(
            child: Text(
              "WE are ready 24/7 hours to support.",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.myComplaint);
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child:
                      Column(
                        children: [
                          Text("S",style: TextStyle(color: UColors.primary,fontSize: 24,fontWeight: FontWeight.w700),),
                          Text("Staff",style: TextStyle(color: UColors.primary,fontWeight: FontWeight.w600,fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.associateSearch);
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                    
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child:
                      Column(
                        children: [
                          Text("A",style: TextStyle(color: UColors.primary,fontSize: 24,fontWeight: FontWeight.w700),),
                          Text("Associate",style: TextStyle(color: UColors.primary,fontWeight: FontWeight.w600,fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}
