import 'package:core/core.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|View,Route')
class AuthRouter extends RootStackRouter {
  /// Routes will be configured in the orchestrator app.
  @override
  final List<AutoRoute> routes = [];
}
