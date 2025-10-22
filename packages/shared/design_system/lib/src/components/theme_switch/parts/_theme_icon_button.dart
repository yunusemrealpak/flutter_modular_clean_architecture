part of '../app_theme_switch.dart';

/// Icon button variant (System → Light → Dark → System)
class _ThemeIconButton extends StatelessWidget {
  const _ThemeIconButton({
    required this.currentTheme,
    required this.onThemeChanged,
  });

  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onThemeChanged;

  void _cycleTheme() {
    final nextTheme = switch (currentTheme) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
    onThemeChanged(nextTheme);
  }

  IconData get _icon => switch (currentTheme) {
        ThemeMode.system => Icons.brightness_auto,
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
      };

  String get _tooltip => switch (currentTheme) {
        ThemeMode.system => 'System theme (tap for light)',
        ThemeMode.light => 'Light theme (tap for dark)',
        ThemeMode.dark => 'Dark theme (tap for system)',
      };

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_icon),
      onPressed: _cycleTheme,
      tooltip: _tooltip,
    );
  }
}
