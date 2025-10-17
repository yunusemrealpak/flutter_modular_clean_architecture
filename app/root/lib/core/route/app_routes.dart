import 'package:app_shell/app_shell.dart';
import 'package:auth/auth.dart';
import 'package:home/core/route/home_routes.dart';
import 'package:profile/core/route/profile_routes.dart';

class AppRoutes {
  static AppShellRoutes get app => AppShellRoutes();
  static AuthRoutes get auth => AuthRoutes();
  static HomeRoutes get home => HomeRoutes();
  static ProfileRoutes get profile => ProfileRoutes();
}
