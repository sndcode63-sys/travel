import 'package:flutter/material.dart';

class AddMeetingWidgets {

/// TEXTFORMFIELD OF ADD MEETINF SCREEN
  Widget addMeetingTextFormField({
    required String hintText,
    required String labelText,
    required TextEditingController controller,
    required String? Function(String? value) validator,
    required TextInputType keyboardType,
    bool obscureText = false,
    int? maxLength,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,          // <-- must pass controller
      validator: validator,            // <-- must pass validator
      keyboardType: keyboardType,      // <-- must pass keyboard type
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black54,
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

  ///text custom widgets
  Widget buildText(
      String text, {
        Color color = Colors.black,
        double fontSize = 16,
        FontWeight fontWeight = FontWeight.w500,
        TextAlign textAlign = TextAlign.start,
      }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }

}

final AddMeetingWidgets addMeetingWidgets = AddMeetingWidgets();
