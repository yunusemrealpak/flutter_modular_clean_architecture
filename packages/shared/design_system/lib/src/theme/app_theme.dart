import 'package:design_system/src/foundation/app_colors.dart';
import 'package:design_system/src/foundation/app_spacing.dart';
import 'package:design_system/src/foundation/app_typography.dart';
import 'package:flutter/material.dart';

/// App theme configuration
///
/// Provides light and dark theme data for the application.
/// Centralizes theme configuration using design tokens.
class AppTheme {
  AppTheme._();

  /// Light theme
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnPrimary,
      secondaryContainer: AppColors.secondaryLight,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
      errorContainer: AppColors.errorLight,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceVariant,
      outline: AppColors.border,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    textButtonTheme: _textButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    cardTheme: _cardTheme,
    appBarTheme: _appBarTheme,
  );

  /// Dark theme
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryLight,
      onPrimary: AppColors.neutral900,
      primaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondaryLight,
      onSecondary: AppColors.neutral900,
      secondaryContainer: AppColors.secondaryDark,
      error: AppColors.errorLight,
      onError: AppColors.neutral900,
      errorContainer: AppColors.error,
      surface: AppColors.neutral900,
      onSurface: AppColors.neutral50,
      surfaceContainerHighest: AppColors.neutral800,
      outline: AppColors.neutral700,
    ),
    scaffoldBackgroundColor: AppColors.neutral900,
    textTheme: _textTheme.apply(
      bodyColor: AppColors.neutral50,
      displayColor: AppColors.neutral50,
    ),
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    textButtonTheme: _textButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    cardTheme: _cardTheme,
    appBarTheme: _appBarTheme,
  );

  // Text Theme
  static final TextTheme _textTheme = TextTheme(
    displayLarge: AppTypography.displayLarge,
    displayMedium: AppTypography.displayMedium,
    displaySmall: AppTypography.displaySmall,
    headlineLarge: AppTypography.headlineLarge,
    headlineMedium: AppTypography.headlineMedium,
    headlineSmall: AppTypography.headlineSmall,
    titleLarge: AppTypography.titleLarge,
    titleMedium: AppTypography.titleMedium,
    titleSmall: AppTypography.titleSmall,
    bodyLarge: AppTypography.bodyLarge,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.bodySmall,
    labelLarge: AppTypography.labelLarge,
    labelMedium: AppTypography.labelMedium,
    labelSmall: AppTypography.labelSmall,
  );

  // Elevated Button Theme
  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.paddingLG,
            vertical: AppSpacing.paddingMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
          textStyle: AppTypography.labelLarge,
          elevation: 0,
          minimumSize: const Size(88, 48),
        ),
      );

  // Outlined Button Theme
  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.paddingLG,
            vertical: AppSpacing.paddingMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          ),
          textStyle: AppTypography.labelLarge,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          minimumSize: const Size(88, 48),
        ),
      );

  // Text Button Theme
  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingLG,
        vertical: AppSpacing.paddingMD,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
      ),
      textStyle: AppTypography.labelLarge,
      minimumSize: const Size(88, 48),
    ),
  );

  // Input Decoration Theme
  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMD,
          vertical: AppSpacing.paddingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          borderSide: const BorderSide(color: AppColors.borderFocus, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          borderSide: const BorderSide(color: AppColors.borderError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
          borderSide: const BorderSide(color: AppColors.borderError, width: 2),
        ),
        labelStyle: AppTypography.bodyMedium,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textDisabled,
        ),
        errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.error),
      );

  // Card Theme
  static final CardThemeData _cardTheme = CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
      side: const BorderSide(color: AppColors.border),
    ),
    margin: const EdgeInsets.all(AppSpacing.marginMD),
  );

  // AppBar Theme
  static final AppBarTheme _appBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    titleTextStyle: AppTypography.titleLarge,
    iconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: AppSpacing.iconMD,
    ),
  );
}
