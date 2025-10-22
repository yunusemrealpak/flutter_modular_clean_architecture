part of 'product_bloc.dart';

/// Events for product feature
@freezed
abstract class ProductEvent with _$ProductEvent {
  /// Load data event
  const factory ProductEvent.loadData({required String id}) =
      ProductEventLoadData;

  /// Add more events here as needed
  /// Example:
  /// const factory ProductEvent.refresh() = ProductEventRefresh;
  /// const factory ProductEvent.delete({required String id}) = ProductEventDelete;
}
