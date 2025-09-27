import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/constents/str_constants.dart';

class LoginWidgets {
  static AppBar customAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 35,
      title: const Text(
        AppStrings.visitApp,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: "OpenSans",
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }
}

final LoginWidgets loginWidgets = LoginWidgets();
