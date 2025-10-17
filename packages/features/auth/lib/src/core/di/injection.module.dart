//@GeneratedMicroModule;AuthPackageModule;package:auth/src/core/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/auth.dart' as _i662;
import 'package:auth/src/core/di/network_module.dart' as _i900;
import 'package:auth/src/data/datasources/auth_local_datasource.dart' as _i885;
import 'package:auth/src/data/datasources/auth_remote_datasource.dart' as _i543;
import 'package:auth/src/data/repositories/auth_repository_impl.dart' as _i402;
import 'package:auth/src/domain/repositories/auth_repository.dart' as _i126;
import 'package:auth/src/domain/usecases/check_auth_status_usecase.dart'
    as _i147;
import 'package:auth/src/domain/usecases/get_current_user_usecase.dart'
    as _i307;
import 'package:auth/src/domain/usecases/login_usecase.dart' as _i25;
import 'package:auth/src/domain/usecases/logout_usecase.dart' as _i545;
import 'package:auth/src/domain/usecases/register_usecase.dart' as _i864;
import 'package:auth/src/presentation/bloc/auth_bloc.dart' as _i1030;
import 'package:injectable/injectable.dart' as _i526;
import 'package:network/network.dart' as _i372;

class AuthPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final networkModule = _$NetworkModule();
    gh.singleton<_i372.NetworkInfo>(() => networkModule.networkInfo);
    gh.lazySingleton<_i372.HttpClient>(() => networkModule.httpClient);
    gh.lazySingleton<_i543.AuthRemoteDataSource>(
        () => _i543.AuthRemoteDataSourceImpl(gh<_i372.HttpClient>()));
    gh.lazySingleton<_i885.AuthLocalDataSource>(
        () => _i885.AuthLocalDataSourceImpl());
    gh.lazySingleton<_i126.AuthRepository>(() => _i402.AuthRepositoryImpl(
          remoteDataSource: gh<_i543.AuthRemoteDataSource>(),
          localDataSource: gh<_i885.AuthLocalDataSource>(),
          networkInfo: gh<_i372.NetworkInfo>(),
        ));
    gh.factory<_i307.GetCurrentUserUseCase>(
        () => _i307.GetCurrentUserUseCase(gh<_i126.AuthRepository>()));
    gh.factory<_i25.LoginUseCase>(
        () => _i25.LoginUseCase(gh<_i126.AuthRepository>()));
    gh.factory<_i545.LogoutUseCase>(
        () => _i545.LogoutUseCase(gh<_i126.AuthRepository>()));
    gh.factory<_i864.RegisterUseCase>(
        () => _i864.RegisterUseCase(gh<_i126.AuthRepository>()));
    gh.factory<_i147.CheckAuthStatusUseCase>(
        () => _i147.CheckAuthStatusUseCase(gh<_i662.AuthRepository>()));
    gh.lazySingleton<_i1030.AuthBloc>(() => _i1030.AuthBloc(
          loginUseCase: gh<_i25.LoginUseCase>(),
          registerUseCase: gh<_i864.RegisterUseCase>(),
          logoutUseCase: gh<_i545.LogoutUseCase>(),
          getCurrentUserUseCase: gh<_i307.GetCurrentUserUseCase>(),
          checkAuthStatusUseCase: gh<_i147.CheckAuthStatusUseCase>(),
        ));
  }
}

class _$NetworkModule extends _i900.NetworkModule {}
