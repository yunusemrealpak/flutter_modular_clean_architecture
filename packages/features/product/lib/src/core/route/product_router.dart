import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

/// Router configuration for product feature
/// Routes are orchestrated by the root app
@AutoRouterConfig(replaceInRouteName: 'Page|View,Route')
@lazySingleton
class ProductRouter extends RootStackRouter {
  /// Routes will be orchestrated in root app
  /// Empty list - root app handles navigation flow
  @override
  final List<AutoRoute> routes = [];
}
