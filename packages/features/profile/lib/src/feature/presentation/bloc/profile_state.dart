part of 'profile_bloc.dart';

/// States for profile BLoC
@freezed
class ProfileState with _$ProfileState {
  /// Initial state - no operation has been performed yet
  const factory ProfileState.initial() = ProfileStateInitial;

  /// Loading state - an operation is in progress
  const factory ProfileState.loading() = ProfileStateLoading;

  /// Loaded state - data has been successfully loaded
  /// [data] can be any type (String, Entity, List, etc.)
  const factory ProfileState.loaded(dynamic data) = ProfileStateLoaded;

  /// Error state - an error occurred during an operation
  const factory ProfileState.error(String message) = ProfileStateError;

  /// Delete success state - item successfully deleted
  const factory ProfileState.deleteSuccess() = ProfileStateDeleteSuccess;

  /// Add more states here as needed
  /// Examples:
  ///
  /// const factory ProfileState.updateSuccess() = ProfileStateUpdateSuccess;
  ///
  /// const factory ProfileState.createSuccess(dynamic data) = ProfileStateCreateSuccess;
  ///
  /// const factory ProfileState.empty() = ProfileStateEmpty;
  ///
  /// const factory ProfileState.searching() = ProfileStateSearching;
}
