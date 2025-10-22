import 'package:app_shell/app_shell.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:home/home.dart';
import 'package:profile/core/di/injection.module.dart';
import 'package:root/core/di/injection_container.config.dart';
import 'package:session/session.dart';
import 'package:theming/theming.dart';

final GetIt getIt = GetIt.I;

@InjectableInit(
  externalPackageModulesBefore: [ExternalModule(ThemingPackageModule)],
  externalPackageModulesAfter: [
    ExternalModule(HomePackageModule),
    ExternalModule(ProfilePackageModule),
    ExternalModule(AuthPackageModule),
    ExternalModule(SessionPackageModule),
    ExternalModule(AppShellPackageModule),
  ],
)
Future<void> configureDependencies() async {
  getIt.init();
}
