import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final String obscuringCharacter;

  /// New parameter for custom input formatters
  final List<TextInputFormatter>? inputFormatters;

  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? labelColor;
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
    this.obscuringCharacter = '•',
    this.inputFormatters,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.fillColor,
    this.hintColor,
    this.labelColor,
    this.borderRadius = 12,
    this.borderWidth = 1.2,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
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
      inputFormatters: inputFormatters,
      style: textStyle ??
          theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding,
        counterText: '',
        hintStyle: hintStyle ??
            inputTheme.hintStyle?.copyWith(color: hintColor ?? theme.hintColor),
        labelStyle: labelStyle ??
            inputTheme.labelStyle?.copyWith(
              color: labelColor ?? theme.colorScheme.onSurface,
            ),
        errorStyle: errorStyle ?? inputTheme.errorStyle,
        filled: true,
        fillColor: fillColor ?? inputTheme.fillColor ?? theme.cardColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? theme.dividerColor,
            width: borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: focusedBorderColor ?? theme.primaryColor,
            width: borderWidth + 0.1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: errorBorderColor ?? theme.colorScheme.error,
            width: borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: errorBorderColor ?? theme.colorScheme.error,
            width: borderWidth + 0.5,
          ),
        ),
      ),
    );
  }
}
