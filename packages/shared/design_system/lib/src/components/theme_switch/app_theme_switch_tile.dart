import 'package:flutter/material.dart';
import 'package:design_system/src/foundation/app_spacing.dart';
import 'package:design_system/src/foundation/app_typography_responsive.dart';

/// Compact theme switcher with label
///
/// Combines icon and switch with optional label.
/// Use this in settings pages or lists.
///
/// Example:
/// ```dart
/// AppThemeSwitchTile(
///   currentTheme: ThemeMode.dark,
///   onThemeChanged: (mode) => themeManager.setThemeMode(mode),
///   title: 'Dark Mode',
///   subtitle: 'Reduces eye strain',
/// )
/// ```
class AppThemeSwitchTile extends StatelessWidget {
  const AppThemeSwitchTile({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
    this.title = 'Dark Mode',
    this.subtitle,
  });

  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onThemeChanged;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = currentTheme == ThemeMode.dark;

    return SwitchListTile(
      value: isDark,
      onChanged: (value) {
        onThemeChanged(value ? ThemeMode.dark : ThemeMode.light);
      },
      title: Text(title, style: AppTypographyResponsive.titleMedium),
      subtitle: subtitle != null
          ? Text(subtitle!, style: AppTypographyResponsive.bodySmall)
          : null,
      secondary: Icon(
        isDark ? Icons.dark_mode : Icons.light_mode,
        size: AppSpacing.iconMD,
      ),
    );
  }
}
