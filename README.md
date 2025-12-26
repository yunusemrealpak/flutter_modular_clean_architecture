# Flutter Modular Clean Architecture

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Melos-1B1F23?style=for-the-badge&logo=dart&logoColor=white" alt="Melos"/>
  <img src="https://img.shields.io/github/license/yunusemrealpak/flutter_modular_clean_architecture?style=for-the-badge" alt="License"/>
</p>

<p align="center">
  A production-ready Flutter monorepo powered by <strong>Melos</strong>. Built with modular feature packages, clean architecture, and shared infrastructure for scalable app development.
</p>

---

## ✨ Features

- 🏗️ **Clean Architecture** — Domain, Data, and Presentation layers with clear separation of concerns
- 📦 **Modular Structure** — Independent feature packages for better scalability and team collaboration
- 🔧 **Melos Powered** — Efficient monorepo management with automated scripts
- 🎯 **BLoC Pattern** — Predictable state management across all features
- 💉 **Dependency Injection** — Clean and testable code with GetIt
- 🧪 **Test Ready** — Pre-configured testing setup for unit, widget, and integration tests
- 🚀 **Production Ready** — Battle-tested architecture patterns used in real-world apps

## 📁 Project Structure

```
flutter_modular_clean_architecture/
├── app/
│   └── root/                    # Main application entry point
├── packages/
│   ├── core/                    # Shared infrastructure
│   │   ├── core_network/        # API client, interceptors, error handling
│   │   ├── core_ui/             # Shared widgets, themes, design system
│   │   ├── core_utils/          # Common utilities and extensions
│   │   └── core_storage/        # Local storage abstractions
│   └── features/                # Feature modules
│       ├── feature_auth/        # Authentication feature
│       ├── feature_home/        # Home feature
│       └── feature_*/           # Other features...
├── scripts/                     # Automation scripts
├── docs/                        # Documentation
├── melos.yaml                   # Melos configuration
└── pubspec.yaml                 # Root pubspec
```

## 🏛️ Architecture Overview

This project follows **Clean Architecture** principles with a **Feature-First** approach:

```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                      │
│                   (BLoC, Pages, Widgets)                     │
├─────────────────────────────────────────────────────────────┤
│                        Domain Layer                          │
│              (Entities, Use Cases, Repositories)             │
├─────────────────────────────────────────────────────────────┤
│                         Data Layer                           │
│        (Repository Impl, Data Sources, Models/DTOs)         │
└─────────────────────────────────────────────────────────────┘
```

### Layer Responsibilities

| Layer | Responsibility |
|-------|---------------|
| **Presentation** | UI components, state management (BLoC), user interaction handling |
| **Domain** | Business logic, use cases, entity definitions, repository contracts |
| **Data** | API calls, local storage, data mapping, repository implementations |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Melos (`dart pub global activate melos`)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yunusemrealpak/flutter_modular_clean_architecture.git
   cd flutter_modular_clean_architecture
   ```

2. **Bootstrap the project**
   ```bash
   melos bootstrap
   ```

3. **Run the app**
   ```bash
   cd app/root
   flutter run
   ```

## 📜 Melos Commands

| Command | Description |
|---------|-------------|
| `melos bootstrap` | Install dependencies for all packages |
| `melos clean` | Clean all packages |
| `melos analyze` | Run static analysis on all packages |
| `melos test` | Run tests across all packages |
| `melos build_runner` | Run build_runner for code generation |
| `melos format` | Format code in all packages |

## 🧩 Creating a New Feature

1. Create a new package under `packages/features/`:
   ```bash
   ./scripts/create_feature.sh feature_profile
   ```

2. The script will generate:
   ```
   feature_profile/
   ├── lib/
   │   ├── src/
   │   │   ├── data/
   │   │   │   ├── datasources/
   │   │   │   ├── models/
   │   │   │   └── repositories/
   │   │   ├── domain/
   │   │   │   ├── entities/
   │   │   │   ├── repositories/
   │   │   │   └── usecases/
   │   │   └── presentation/
   │   │       ├── bloc/
   │   │       ├── pages/
   │   │       └── widgets/
   │   └── feature_profile.dart
   ├── test/
   └── pubspec.yaml
   ```

3. Register the feature in the main app's dependency injection

## 🧪 Testing

Run all tests:
```bash
melos test
```

Run tests with coverage:
```bash
melos test -- --coverage
```

Run tests for a specific package:
```bash
cd packages/features/feature_auth
flutter test
```


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Uncle Bob's Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Reso Coder's Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [Melos](https://melos.invertase.dev/)

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/yunusemrealpak">Yunus Emre Alpak</a>
</p>
