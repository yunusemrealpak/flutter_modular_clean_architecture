part of 'app_bloc.dart';

/// App Shell states
@freezed
abstract class AppState with _$AppState {
  /// Initial state with default tab index
  const factory AppState.initial({@Default(0) int currentTabIndex}) =
      AppStateInitial;

  /// Tab changed state
  const factory AppState.tabChanged({required int currentTabIndex}) =
      AppStateTabChanged;
}
