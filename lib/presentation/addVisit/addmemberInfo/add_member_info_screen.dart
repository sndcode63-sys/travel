import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/constents/app_sizes.dart';
import 'package:travell_booking_app/utlis/ui/extension.dart';
import '../../../utlis/constents/color_constants.dart';
import '../../../utlis/custom_widgets/custom_button.dart';

class AddMemberInfoScreen extends StatelessWidget {
  const AddMemberInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
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
                            "Add Visit",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Add Client Information",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.black54),
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.h,
                        Align(
                          alignment: Alignment.center,

                          child: Text(
                            "Location is disable.\nPlease enable location first to add visit data.",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        20.h,
                        CustomButton(
                          text: "SCHEME: AERO RESIDENCY",
                          backgroundColor: AppColors.primary,
                          fontWeight: FontWeight.w400,
                          borderRadius: 15,
                          fontSize: 16,
                          height: 50,
                        ),
                        20.h,
                        addMemberTextFormField(hintText: "Client Name"),
                        20.h,
                        addMemberTextFormField(hintText: "Father/Spouse Name"),
                        20.h,
                        addMemberTextFormField(hintText: "Email"),
                        20.h,
                        addMemberTextFormField(hintText: "Contact No."),
                        20.h,
                        addMemberTextFormField(hintText: "Remark (Optional)"),
                        100.h,
                        CustomButton(
                          text: "CONTINUE",
                          backgroundColor: Colors.grey.withAlpha(77),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addMemberTextFormField({required String hintText}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText, // Dynamic hint text
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withAlpha(76)),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
