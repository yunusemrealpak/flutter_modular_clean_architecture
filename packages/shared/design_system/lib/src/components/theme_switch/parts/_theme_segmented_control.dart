part of '../app_theme_switch.dart';

/// Segmented control variant (Light / System / Dark)
class _ThemeSegmentedControl extends StatelessWidget {
  const _ThemeSegmentedControl({
    required this.currentTheme,
    required this.onThemeChanged,
  });

  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode, size: AppSpacing.iconSM),
          label: Text('Light'),
        ),
        ButtonSegment(
          value: ThemeMode.system,
          icon: Icon(Icons.brightness_auto, size: AppSpacing.iconSM),
          label: Text('Auto'),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode, size: AppSpacing.iconSM),
          label: Text('Dark'),
        ),
      ],
      selected: {currentTheme},
      onSelectionChanged: (Set<ThemeMode> selected) {
        onThemeChanged(selected.first);
      },
    );
  }
}
