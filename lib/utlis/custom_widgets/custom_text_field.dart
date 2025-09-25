import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final String obscuringCharacter;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  final int? maxLength;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;

  final bool showStar;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.obscuringCharacter = "•",
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.inputFormatters,
    this.showStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        label: labelText != null
            ? RichText(
          text: TextSpan(
            text: labelText,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
            children: showStar
                ? const [
              TextSpan(
                text: " *",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ]
                : [],
          ),
        )
            : null,
        hintText: hintText,
        counterText: "",
        hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 1.2),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.2),
        ),
      ),
    );
  }
}
