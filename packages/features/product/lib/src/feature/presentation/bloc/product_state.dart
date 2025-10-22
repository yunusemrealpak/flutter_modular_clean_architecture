part of 'product_bloc.dart';

/// States for product feature
@freezed
class ProductState with _$ProductState {
  /// Initial state - no data loaded yet
  const factory ProductState.initial() = ProductStateInitial;

  /// Loading state - data is being fetched
  const factory ProductState.loading() = ProductStateLoading;

  /// Loaded state - data successfully fetched
  const factory ProductState.loaded(ExampleEntity data) =
      ProductStateLoaded;

  /// Error state - something went wrong
  const factory ProductState.error(String message) =
      ProductStateError;
}
