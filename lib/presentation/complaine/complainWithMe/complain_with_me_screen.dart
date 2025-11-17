import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/utlis/constents/colors.dart';
import '../../../models/complain/get_dispute.dart';

class ComplainWithMeScreen extends StatelessWidget {
  const ComplainWithMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Data data = Get.arguments;

    return Scaffold(
      backgroundColor: UColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h,bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                      ),
                      Text(
                        "Dispute Details",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _title("Subject"),
                _value(data.subject),

                _title("From User Type"),
                _value(data.fromUserType),

                _title("From Name"),
                _value(data.fromName),

                _title("From Phone"),
                _value(data.fromPhoneNumber),

                _title("To User Type"),
                _value(data.toUserType),

                _title("To Name"),
                _value(data.toName),

                _title("To Phone"),
                _value(data.toPhoneNumber),

                _title("Dispute Reason"),
                _value(data.disputeReason?.toString()),

                _title("Case Details"),
                _value(data.caseInDetails),

                _title("Last Status"),
                _value(data.lastStatus),

                _title("Entry Role"),
                _value(data.entryRole),

                _title("Scheme Name"),
                _value(data.schemeName?.toString()),

                _title("Plot Name"),
                _value(data.plotName?.toString()),

                _title("Dispute Date"),
                _value(data.disputeDate),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _value(String? text) {
    return Text(
      text ?? "-",
      style: const TextStyle(fontSize: 15, color: Colors.black87),
    );
  }
}
