import 'package:app_shell/app_shell.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:home/home.dart';
import 'package:profile/profile.dart';
import 'package:root/core/route/app_routes.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|View,Route')
class AppRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: AppRoutes.auth.login, page: LoginRoute.page, initial: true),
    AutoRoute(
      path: AppRoutes.app.appShell,
      page: AppRoute.page,
      children: [
        AutoRoute(
          path: AppRoutes.app.homeTab,
          page: HomeTabRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: AppRoutes.home.home),
            AutoRoute(path: AppRoutes.home.home, page: HomeRoute.page),
          ],
        ),
        AutoRoute(
          path: AppRoutes.app.profileTab,
          page: ProfileTabRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: AppRoutes.profile.profile),
            AutoRoute(path: AppRoutes.profile.profile, page: ProfileRoute.page),
          ],
        ),
      ],
    ),
  ];
}
