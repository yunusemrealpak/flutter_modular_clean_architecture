/// Route path constants for product feature
/// Used for type-safe navigation across the app
final class ProductRoutes {
  static ProductRoutes? _instance;

  /// Singleton factory constructor
  factory ProductRoutes() => _instance ??= ProductRoutes._();

  /// Private constructor
  ProductRoutes._();

  /// Main route for product
  String get main => '/product';

  /// Add more routes here as needed
  /// Example:
  /// String get details => '/product/details';
}
