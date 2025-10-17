// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_shell/src/core/router/tab_routers.dart' as _i2;
import 'package:app_shell/src/presentation/pages/app_page.dart' as _i1;
import 'package:auto_route/auto_route.dart' as _i3;

/// generated route for
/// [_i1.AppPage]
class AppRoute extends _i3.PageRouteInfo<void> {
  const AppRoute({List<_i3.PageRouteInfo>? children})
    : super(AppRoute.name, initialChildren: children);

  static const String name = 'AppRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppPage();
    },
  );
}

/// generated route for
/// [_i2.HomeTabPage]
class HomeTabRoute extends _i3.PageRouteInfo<void> {
  const HomeTabRoute({List<_i3.PageRouteInfo>? children})
    : super(HomeTabRoute.name, initialChildren: children);

  static const String name = 'HomeTabRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeTabPage();
    },
  );
}

/// generated route for
/// [_i2.ProfileTabPage]
class ProfileTabRoute extends _i3.PageRouteInfo<void> {
  const ProfileTabRoute({List<_i3.PageRouteInfo>? children})
    : super(ProfileTabRoute.name, initialChildren: children);

  static const String name = 'ProfileTabRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.ProfileTabPage();
    },
  );
}
