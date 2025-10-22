import 'package:core/core.dart';
import 'package:storage/storage.dart';

abstract class IThemeLocalDataSource {
  Future<void> cacheThemeMode(String themeMode);
  Future<String?> getCachedThemeMode();
}

@LazySingleton(as: IThemeLocalDataSource)
class ThemingLocalDatasource implements IThemeLocalDataSource {
  final StorageHelper<SettingsDbModel> storageHelper;

  ThemingLocalDatasource(this.storageHelper);

  @override
  Future<void> cacheThemeMode(String themeMode) async {
    final settings = SettingsDbModel(themeMode: themeMode);
    await storageHelper.save(settings);
  }

  @override
  Future<String?> getCachedThemeMode() async {
    final settings = await storageHelper.findById(0);
    if (settings != null) {
      return settings.themeMode;
    }
    return null;
  }
}
