# product

A Flutter package for product feature.

## Features

- Clean Architecture implementation
- BLoC pattern for state management
- Dependency Injection with Injectable
- Type-safe routing with AutoRoute

## Usage

```dart
import 'package:product/product.dart';
```

## Development

### Code Generation

Run code generation:

```bash
cd packages/feature/product
dart run build_runner build --delete-conflicting-outputs
```

Watch mode:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Testing

```bash
flutter test
```
