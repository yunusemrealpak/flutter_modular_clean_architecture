//@GeneratedMicroModule;AuthPackageModule;package:auth/src/core/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/auth.dart' as _i662;
import 'package:auth/src/feature/data/datasources/auth_local_datasource.dart'
    as _i166;
import 'package:auth/src/feature/data/datasources/auth_remote_datasource.dart'
    as _i428;
import 'package:auth/src/feature/data/repositories/auth_repository_impl.dart'
    as _i14;
import 'package:auth/src/feature/domain/repositories/auth_repository.dart'
    as _i8;
import 'package:auth/src/feature/domain/usecases/check_auth_status_usecase.dart'
    as _i862;
import 'package:auth/src/feature/domain/usecases/get_current_user_usecase.dart'
    as _i963;
import 'package:auth/src/feature/domain/usecases/login_usecase.dart' as _i1052;
import 'package:auth/src/feature/domain/usecases/logout_usecase.dart' as _i886;
import 'package:auth/src/feature/domain/usecases/register_usecase.dart'
    as _i767;
import 'package:auth/src/feature/presentation/bloc/auth_bloc.dart' as _i483;
import 'package:injectable/injectable.dart' as _i526;
import 'package:network/network.dart' as _i372;
import 'package:storage/storage.dart' as _i431;

class AuthPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i166.AuthLocalDataSource>(() =>
        _i166.AuthLocalDataSourceImpl(
            gh<_i431.StorageHelper<_i431.AuthTokenDbModel>>()));
    gh.lazySingleton<_i428.AuthRemoteDataSource>(
        () => _i428.AuthRemoteDataSourceImpl(gh<_i372.HttpClient>()));
    gh.lazySingleton<_i8.AuthRepository>(() => _i14.AuthRepositoryImpl(
          remoteDataSource: gh<_i428.AuthRemoteDataSource>(),
          localDataSource: gh<_i166.AuthLocalDataSource>(),
          networkInfo: gh<_i372.NetworkInfo>(),
        ));
    gh.factory<_i862.CheckAuthStatusUseCase>(
        () => _i862.CheckAuthStatusUseCase(gh<_i662.AuthRepository>()));
    gh.factory<_i963.GetCurrentUserUseCase>(
        () => _i963.GetCurrentUserUseCase(gh<_i8.AuthRepository>()));
    gh.factory<_i1052.LoginUseCase>(
        () => _i1052.LoginUseCase(gh<_i8.AuthRepository>()));
    gh.factory<_i886.LogoutUseCase>(
        () => _i886.LogoutUseCase(gh<_i8.AuthRepository>()));
    gh.factory<_i767.RegisterUseCase>(
        () => _i767.RegisterUseCase(gh<_i8.AuthRepository>()));
    gh.lazySingleton<_i483.AuthBloc>(() => _i483.AuthBloc(
          loginUseCase: gh<_i1052.LoginUseCase>(),
          registerUseCase: gh<_i767.RegisterUseCase>(),
          logoutUseCase: gh<_i886.LogoutUseCase>(),
          getCurrentUserUseCase: gh<_i963.GetCurrentUserUseCase>(),
          checkAuthStatusUseCase: gh<_i862.CheckAuthStatusUseCase>(),
        ));
  }
}
