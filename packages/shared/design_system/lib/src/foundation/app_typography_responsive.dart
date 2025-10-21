import 'package:design_system/src/foundation/app_responsive.dart';
import 'package:design_system/src/foundation/app_typography.dart';
import 'package:flutter/material.dart';

/// Responsive typography that scales based on screen size
///
/// Use this instead of AppTypography for responsive font sizes.
/// All values scale based on screen width relative to reference size (390px).
///
/// Example:
/// ```dart
/// Text('Hello', style: AppTypographyResponsive.bodyLarge)
/// ```
class AppTypographyResponsive {
  AppTypographyResponsive._();

  // Helper method to scale TextStyle
  static TextStyle _scale(TextStyle style) {
    return style.copyWith(
      fontSize: style.fontSize != null ? AppResponsive.sp(style.fontSize!) : null,
      letterSpacing: style.letterSpacing != null
          ? AppResponsive.sp(style.letterSpacing!)
          : null,
    );
  }

  // Display styles (Large headlines)
  static TextStyle get displayLarge => _scale(AppTypography.displayLarge);
  static TextStyle get displayMedium => _scale(AppTypography.displayMedium);
  static TextStyle get displaySmall => _scale(AppTypography.displaySmall);

  // Headline styles (Section headers)
  static TextStyle get headlineLarge => _scale(AppTypography.headlineLarge);
  static TextStyle get headlineMedium => _scale(AppTypography.headlineMedium);
  static TextStyle get headlineSmall => _scale(AppTypography.headlineSmall);

  // Title styles (Card headers, Dialog titles)
  static TextStyle get titleLarge => _scale(AppTypography.titleLarge);
  static TextStyle get titleMedium => _scale(AppTypography.titleMedium);
  static TextStyle get titleSmall => _scale(AppTypography.titleSmall);

  // Body styles (Main content)
  static TextStyle get bodyLarge => _scale(AppTypography.bodyLarge);
  static TextStyle get bodyMedium => _scale(AppTypography.bodyMedium);
  static TextStyle get bodySmall => _scale(AppTypography.bodySmall);

  // Label styles (Buttons, tabs, form labels)
  static TextStyle get labelLarge => _scale(AppTypography.labelLarge);
  static TextStyle get labelMedium => _scale(AppTypography.labelMedium);
  static TextStyle get labelSmall => _scale(AppTypography.labelSmall);
}
