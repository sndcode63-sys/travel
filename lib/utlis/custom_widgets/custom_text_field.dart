import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry contentPadding;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final String obscuringCharacter; // new


  // 🎨 Customization Props
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color fillColor;
  final Color hintColor;
  final Color labelColor;
  final double borderRadius;
  final double borderWidth;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;


  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.contentPadding =
    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.obscuringCharacter = '•', // default dot


    // 🎨 Defaults
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.fillColor = Colors.white,
    this.hintColor = Colors.grey,
    this.labelColor = Colors.black,
    this.borderRadius = 12,
    this.borderWidth = 1.2,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: obscuringCharacter, // pass here
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      maxLength: maxLength,
      maxLines: maxLines,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      style: textStyle ?? const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle ??
            TextStyle(fontSize: 14, color: hintColor.withOpacity(0.7)),
        labelStyle: labelStyle ??
            TextStyle(fontSize: 15, color: labelColor, fontWeight: FontWeight.w500),
        errorStyle: errorStyle ??
            const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor,
        contentPadding: contentPadding,
        counterText: '',

        // Borders
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: focusedBorderColor, width: borderWidth + 0.8),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: errorBorderColor, width: borderWidth + 0.8),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
