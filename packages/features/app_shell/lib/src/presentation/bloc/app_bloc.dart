import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

/// App Shell BLoC
/// Manages bottom navigation state and listens to navigation events from EventBus
@lazySingleton
class AppBloc extends Bloc<AppEvent, AppState> {
  StreamSubscription<ChangeBottomNavIndexEvent>? _eventBusSubscription;

  AppBloc() : super(const AppState.initial()) {
    // Register event handlers
    on<AppEventChangeTabIndex>(_onChangeTabIndex);

    // Subscribe to EventBus navigation events
    _subscribeToEventBus();
  }

  /// Handles tab index change events
  Future<void> _onChangeTabIndex(
    AppEventChangeTabIndex event,
    Emitter<AppState> emit,
  ) async {
    emit(AppState.tabChanged(currentTabIndex: event.index));
  }

  /// Subscribe to ChangeBottomNavIndexEvent from EventBus
  void _subscribeToEventBus() {
    _eventBusSubscription = EventBus.I.subscribe<ChangeBottomNavIndexEvent>((
      event,
    ) {
      // When we receive a navigation event from EventBus,
      // convert it to a local bloc event
      add(AppEvent.changeTabIndex(index: event.newIndex));
    });
  }

  @override
  Future<void> close() {
    // Cancel EventBus subscription when bloc is closed
    _eventBusSubscription?.cancel();
    return super.close();
  }
}
