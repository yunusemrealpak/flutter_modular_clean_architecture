# BLoC Pattern Rehberi

## Dosya Yapısı

```
lib/src/presentation/bloc/
├── feature_bloc.dart         # Ana dosya
├── feature_event.dart        # Events (part of)
├── feature_state.dart        # States (part of)
└── feature_bloc.freezed.dart # Generated
```

## 1. Ana BLoC Dosyası

**File**: `feature_bloc.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'feature_bloc.freezed.dart';
part 'feature_event.dart';
part 'feature_state.dart';

@lazySingleton
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final SomeUseCase useCase;

  FeatureBloc({required this.useCase})
    : super(const FeatureState.initial()) {
    on<FeatureEventAction>(_onAction);
  }

  Future<void> _onAction(
    FeatureEventAction event,
    Emitter<FeatureState> emit,
  ) async {
    emit(const FeatureState.loading());
    // Logic here
  }
}
```

## 2. Event Dosyası

**File**: `feature_event.dart`

```dart
part of 'feature_bloc.dart';

@freezed
class FeatureEvent with _$FeatureEvent {
  const factory FeatureEvent.action() = FeatureEventAction;

  const factory FeatureEvent.loadData({
    required String id,
    @Default(false) bool force,
  }) = FeatureEventLoadData;
}
```

## 3. State Dosyası

**File**: `feature_state.dart`

```dart
part of 'feature_bloc.dart';

@freezed
class FeatureState with _$FeatureState {
  const factory FeatureState.initial() = FeatureStateInitial;
  const factory FeatureState.loading() = FeatureStateLoading;
  const factory FeatureState.success(Data data) = FeatureStateSuccess;
  const factory FeatureState.error(String message) = FeatureStateError;
}
```

## 4. Code Generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 5. UI'da Kullanım

```dart
BlocBuilder<FeatureBloc, FeatureState>(
  builder: (context, state) {
    return state.map(
      initial: (_) => InitialWidget(),
      loading: (_) => LoadingWidget(),
      success: (s) => SuccessWidget(data: s.data),
      error: (s) => ErrorWidget(message: s.message),
    );
  },
)

// Event trigger
context.read<FeatureBloc>().add(
  const FeatureEvent.action(),
);
```

## EventBus Entegrasyonu (Opsiyonel)

```dart
@lazySingleton
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final EventBus _eventBus;
  StreamSubscription? _subscription;

  FeatureBloc({required EventBus eventBus})
    : _eventBus = eventBus,
      super(const FeatureState.initial()) {
    on<FeatureEventAction>(_onAction);
    _subscribeToEventBus();
  }

  void _subscribeToEventBus() {
    _subscription = _eventBus.subscribe<ExternalEvent>(
      (event) => add(const FeatureEvent.action()),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
```

## Checklist

- [ ] 3 dosya oluştur (bloc, event, state)
- [ ] `part of 'feature_bloc.dart'` ekle (event/state)
- [ ] `part 'feature_bloc.freezed.dart'` ekle (bloc)
- [ ] `@freezed` annotation ekle (event/state)
- [ ] `@lazySingleton` ekle (bloc)
- [ ] Event handler'ları register et
- [ ] `build_runner build` çalıştır
