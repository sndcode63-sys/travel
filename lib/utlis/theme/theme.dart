
import 'package:flutter/material.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/appbar_theme.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/card_theme.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/checkbox_theme.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/chip_theme.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/elevated_button_theme.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/outlined_button_theme.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/radio_button_theme.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/text_field_theme.dart';
import 'package:travell_booking_app/utlis/theme/widgets_theme/text_theme.dart';

import '../constents/colors.dart';
import 'widgets_theme/bottom_sheet_theme.dart';


class UAppTheme {
  // private constructor
  UAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColor: UColors.primary,
    disabledColor: UColors.grey,
    textTheme: UTextTheme.lightTextTheme,
    chipTheme: UChipTheme.lightChipTheme,
    scaffoldBackgroundColor: UColors.white,
    appBarTheme: UAppBarTheme.lightAppBarTheme,
    checkboxTheme: UCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: UBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: UElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: UTextFormFieldTheme.lightInputDecorationTheme,
    cardTheme: UCardTheme.lightCardTheme,
    radioTheme: URadioTheme.lightRadioTheme,


  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: UColors.primary,
    disabledColor: UColors.grey,
    textTheme: UTextTheme.darkTextTheme,
    chipTheme: UChipTheme.darkChipTheme,
    scaffoldBackgroundColor: UColors.black,
    appBarTheme: UAppBarTheme.darkAppBarTheme,
    checkboxTheme: UCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: UBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: UElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: UTextFormFieldTheme.darkInputDecorationTheme,
    cardTheme: UCardTheme.darkCardTheme,
    radioTheme: URadioTheme.darkRadioTheme,


  );
}
