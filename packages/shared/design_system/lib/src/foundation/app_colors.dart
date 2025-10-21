import 'package:flutter/material.dart';

/// App color palette and semantic colors
///
/// This class defines all colors used across the app.
/// Divided into: Primary, Secondary, Neutral, Semantic, and Surface colors
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFFA5B4FC);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Secondary Colors
  static const Color secondary = Color(0xFF8B5CF6); // Purple
  static const Color secondaryLight = Color(0xFFC4B5FD);
  static const Color secondaryDark = Color(0xFF7C3AED);

  // Neutral Colors (Gray Scale)
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);

  // Semantic Colors
  static const Color success = Color(0xFF10B981); // Green
  static const Color successLight = Color(0xFF6EE7B7);
  static const Color error = Color(0xFFEF4444); // Red
  static const Color errorLight = Color(0xFFFCA5A5);
  static const Color warning = Color(0xFFF59E0B); // Orange
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color info = Color(0xFF3B82F6); // Blue
  static const Color infoLight = Color(0xFF93C5FD);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFAFAFA);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = neutral900;
  static const Color textSecondary = neutral600;
  static const Color textDisabled = neutral400;
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = neutral200;
  static const Color borderFocus = primary;
  static const Color borderError = error;
}
