import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theming/src/feature/domain/repository/i_theming_repository.dart';

@lazySingleton
final class ThemeManager with ChangeNotifier {
  ThemeManager(this._themeRepository);

  final IThemeRepository _themeRepository;

  ValueNotifier<ThemeMode> currentThemeMode = ValueNotifier(ThemeMode.system);

  Future<ThemeMode> getThemeMode() async {
    final themeModeString = await _themeRepository.getThemeMode();
    final themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == themeModeString,
      orElse: () => ThemeMode.system,
    );
    currentThemeMode.value = themeMode;
    return themeMode;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _themeRepository.saveThemeMode(themeMode.name);
    currentThemeMode.value = themeMode;
  }
}
