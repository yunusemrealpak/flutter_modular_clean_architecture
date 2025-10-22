part of '../app_theme_switch.dart';

/// Toggle switch variant (Light ↔ Dark)
class _ThemeToggleSwitch extends StatelessWidget {
  const _ThemeToggleSwitch({
    required this.currentTheme,
    required this.onThemeChanged,
  });

  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = currentTheme == ThemeMode.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode,
          size: AppSpacing.iconSM,
          color: isDark ? AppColors.textDisabled : AppColors.primary,
        ),
        const SizedBox(width: AppSpacing.gapXS),
        Switch(
          value: isDark,
          onChanged: (value) {
            onThemeChanged(value ? ThemeMode.dark : ThemeMode.light);
          },
        ),
        const SizedBox(width: AppSpacing.gapXS),
        Icon(
          Icons.dark_mode,
          size: AppSpacing.iconSM,
          color: isDark ? AppColors.primary : AppColors.textDisabled,
        ),
      ],
    );
  }
}
