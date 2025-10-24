import 'package:core/core.dart';
import 'package:root/core/di/injection_container.config.dart';

final GetIt getIt = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}
