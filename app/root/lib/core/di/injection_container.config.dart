// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:network/network.dart' as _i372;
import 'package:root/core/di/injection_module.dart' as _i352;
import 'package:root/core/event/app_event_listener.dart' as _i332;
import 'package:storage/storage.dart' as _i431;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    gh.singleton<_i372.NetworkInfo>(() => injectionModule.networkInfo);
    gh.singleton<_i332.AppEventListener>(() => _i332.AppEventListener());
    gh.lazySingleton<_i372.HttpClient>(() => injectionModule.httpClient);
    gh.lazySingleton<_i431.StorageHelper<_i431.AuthTokenDbModel>>(
      () => injectionModule.authStore,
    );
    gh.lazySingleton<_i431.StorageHelper<_i431.SettingsDbModel>>(
      () => injectionModule.settingsStore,
    );
    return this;
  }
}

class _$InjectionModule extends _i352.InjectionModule {}
