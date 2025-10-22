abstract class IThemeRepository {
  Future<void> saveThemeMode(String themeMode);
  Future<String?> getThemeMode();
}
