import 'dart:async';

import 'base_event.dart';

/// Type definition for event handlers
typedef EventHandler<T extends BaseEvent> = void Function(T event);

/// Event Bus implementation using Singleton pattern
/// Provides publish-subscribe mechanism for decoupled communication
class EventBus {
  EventBus._();
  static final EventBus I = EventBus._();

  /// Stream controller for broadcasting events
  final StreamController<BaseEvent> _streamController =
      StreamController<BaseEvent>.broadcast();

  /// Map of event handlers by event type
  final Map<Type, List<EventHandler<BaseEvent>>> _handlers = {};

  /// Publish an event to all subscribers
  /// Events are delivered asynchronously
  void publish<T extends BaseEvent>(T event) {
    _streamController.add(event);

    // Also trigger specific handlers
    final handlers = _handlers[T];
    if (handlers != null) {
      for (final handler in handlers) {
        try {
          handler(event);
        } catch (e) {
          // Log error but don't stop other handlers
          // ignore: avoid_print
          print('Error in event handler for ${event.eventName}: $e');
        }
      }
    }
  }

  /// Subscribe to a specific event type
  /// Returns a subscription that can be cancelled
  StreamSubscription<T> subscribe<T extends BaseEvent>(
    EventHandler<T> handler,
  ) {
    return _streamController.stream
        .where((event) => event is T)
        .cast<T>()
        .listen(handler);
  }

  /// Register a typed event handler
  /// This is alternative to subscribe for better type safety
  void on<T extends BaseEvent>(EventHandler<T> handler) {
    final handlers = _handlers[T] ?? <EventHandler<BaseEvent>>[];
    handlers.add(handler as EventHandler<BaseEvent>);
    _handlers[T] = handlers;
  }

  /// Unregister a specific handler
  void off<T extends BaseEvent>(EventHandler<T> handler) {
    final handlers = _handlers[T];
    if (handlers != null) {
      handlers.remove(handler as EventHandler<BaseEvent>);
      if (handlers.isEmpty) {
        _handlers.remove(T);
      }
    }
  }

  /// Clear all handlers for a specific event type
  void clearHandlers<T extends BaseEvent>() {
    _handlers.remove(T);
  }

  /// Clear all event handlers
  void clearAllHandlers() {
    _handlers.clear();
  }

  /// Dispose the event bus (should only be called on app termination)
  void dispose() {
    _handlers.clear();
    _streamController.close();
  }

  /// Get stream of all events
  Stream<BaseEvent> get stream => _streamController.stream;

  /// Get stream of specific event type
  Stream<T> streamOf<T extends BaseEvent>() {
    return _streamController.stream.where((event) => event is T).cast<T>();
  }
}
