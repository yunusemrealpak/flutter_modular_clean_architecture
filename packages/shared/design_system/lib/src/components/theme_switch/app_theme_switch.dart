import 'package:flutter/material.dart';
import 'package:design_system/src/foundation/app_colors.dart';
import 'package:design_system/src/foundation/app_spacing.dart';
import 'package:design_system/src/components/theme_switch/app_theme_switch_variant.dart';

part 'parts/_theme_toggle_switch.dart';
part 'parts/_theme_icon_button.dart';
part 'parts/_theme_segmented_control.dart';

/// Theme switcher component with multiple variants
///
/// Pure UI component - requires external state management.
/// Pass current theme and callback function from outside.
///
/// Example:
/// ```dart
/// AppThemeSwitch(
///   currentTheme: ThemeMode.dark,
///   onThemeChanged: (mode) {
///     // Your theme change logic here
///     themeManager.setThemeMode(mode);
///   },
/// )
/// ```
class AppThemeSwitch extends StatelessWidget {
  const AppThemeSwitch({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
    this.variant = AppThemeSwitchVariant.toggle,
  });

  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onThemeChanged;
  final AppThemeSwitchVariant variant;

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      AppThemeSwitchVariant.toggle => _ThemeToggleSwitch(
          currentTheme: currentTheme,
          onThemeChanged: onThemeChanged,
        ),
      AppThemeSwitchVariant.iconButton => _ThemeIconButton(
          currentTheme: currentTheme,
          onThemeChanged: onThemeChanged,
        ),
      AppThemeSwitchVariant.segmented => _ThemeSegmentedControl(
          currentTheme: currentTheme,
          onThemeChanged: onThemeChanged,
        ),
    };
  }
}
