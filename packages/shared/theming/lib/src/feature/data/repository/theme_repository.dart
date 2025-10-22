import 'package:core/core.dart';
import 'package:theming/src/feature/data/datasources/theme_local_datasource.dart';
import 'package:theming/src/feature/domain/repository/i_theming_repository.dart';

@LazySingleton(as: IThemeRepository)
final class ThemeRepository implements IThemeRepository {
  final IThemeLocalDataSource localDataSource;

  ThemeRepository(this.localDataSource);

  @override
  Future<String?> getThemeMode() async {
    return await localDataSource.getCachedThemeMode();
  }

  @override
  Future<void> saveThemeMode(String themeMode) async {
    await localDataSource.cacheThemeMode(themeMode);
  }
}
