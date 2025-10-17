import 'package:app_shell/app_shell.dart';
import 'package:auth/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:home/core/di/injection.module.dart';
import 'package:injectable/injectable.dart';
import 'package:profile/core/di/injection.module.dart';
import 'package:root/core/di/injection_container.config.dart';

final GetIt di = GetIt.I;

@InjectableInit(
  externalPackageModulesAfter: [
    ExternalModule(HomePackageModule),
    ExternalModule(ProfilePackageModule),
    ExternalModule(AuthPackageModule),
    ExternalModule(AppShellPackageModule),
  ],
)
Future<void> configureDependencies() async {
  di.init();
}
