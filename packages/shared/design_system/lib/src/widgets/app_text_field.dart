import 'package:flutter/material.dart';
import 'package:design_system/src/foundation/app_spacing.dart';

/// Wrapper for app text fields with consistent styling
///
/// Provides a standardized text input field with optional prefix/suffix icons.
/// Uses theme configuration for styling.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.keyboardType,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: obscureText ? 1 : maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: AppSpacing.iconSM)
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
