import 'package:app_shell/app_shell.dart';
import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:home/core/route/home_router.gr.dart';
import 'package:profile/core/route/profile_router.gr.dart';
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
