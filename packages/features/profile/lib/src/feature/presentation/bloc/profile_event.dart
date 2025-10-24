part of 'profile_bloc.dart';

/// Events for profile BLoC
@freezed
class ProfileEvent with _$ProfileEvent {
  /// Load data event
  /// Use this to fetch initial data
  const factory ProfileEvent.load({
    String? id,
  }) = ProfileEventLoad;

  /// Refresh data event
  /// Use this to reload/refresh existing data
  const factory ProfileEvent.refresh() = ProfileEventRefresh;

  /// Delete data event
  /// Use this to delete an item
  const factory ProfileEvent.delete({
    required String id,
  }) = ProfileEventDelete;

  /// Add more events here as needed
  /// Examples:
  ///
  /// const factory ProfileEvent.update({
  ///   required String id,
  ///   required String name,
  /// }) = ProfileEventUpdate;
  ///
  /// const factory ProfileEvent.create({
  ///   required String name,
  /// }) = ProfileEventCreate;
  ///
  /// const factory ProfileEvent.search({
  ///   required String query,
  /// }) = ProfileEventSearch;
}
