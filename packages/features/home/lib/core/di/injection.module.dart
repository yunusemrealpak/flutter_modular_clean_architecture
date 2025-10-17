//@GeneratedMicroModule;HomePackageModule;package:home/core/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:home/core/home_usecase.dart' as _i841;
import 'package:injectable/injectable.dart' as _i526;

class HomePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i841.HomeUsecase>(() => _i841.HomeUsecase());
  }
}
