// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_shell/app_shell.dart' as _i671;
import 'package:auth/auth.dart' as _i662;
import 'package:get_it/get_it.dart' as _i174;
import 'package:home/core/di/injection.module.dart' as _i1014;
import 'package:injectable/injectable.dart' as _i526;
import 'package:profile/core/di/injection.module.dart' as _i176;
import 'package:root/core/event/app_event_listener.dart' as _i332;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i332.AppEventListener>(() => _i332.AppEventListener());
    await _i1014.HomePackageModule().init(gh);
    await _i176.ProfilePackageModule().init(gh);
    await _i662.AuthPackageModule().init(gh);
    await _i671.AppShellPackageModule().init(gh);
    return this;
  }
}
