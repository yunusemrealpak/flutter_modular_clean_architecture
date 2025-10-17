part of 'app_bloc.dart';

/// App Shell events
@freezed
abstract class AppEvent with _$AppEvent {
  /// Change bottom navigation tab index
  const factory AppEvent.changeTabIndex({required int index}) =
      AppEventChangeTabIndex;
}
