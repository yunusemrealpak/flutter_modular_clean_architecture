#!/bin/bash

# Script to create a new Flutter package with Clean Architecture

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
source "$SCRIPT_DIR/../common/functions.sh"

# Get project root
PROJECT_ROOT=$(get_project_root)

print_header "Flutter Modular Clean Architecture - Package Generator"

# Step 1: Ask for package type
echo -e "${YELLOW}[1/3] Paket türünü seçin:${NC}"
echo "1) Feature (Clean Architecture ile feature modülü)"
echo "2) Shared (Paylaşımlı utility paketi)"
echo "3) Infrastructure (Altyapı servisi paketi)"
echo ""
read -p "Seçiminiz (1-3): " package_type_choice

case $package_type_choice in
    1)
        PACKAGE_TYPE="feature"
        BASE_PATH="$PROJECT_ROOT/packages/features"
        ;;
    2)
        PACKAGE_TYPE="shared"
        BASE_PATH="$PROJECT_ROOT/packages/shared"
        ;;
    3)
        PACKAGE_TYPE="infrastructure"
        BASE_PATH="$PROJECT_ROOT/packages/infrastructure"
        ;;
    *)
        echo -e "${RED}Geçersiz seçim! Script sonlandırılıyor.${NC}"
        exit 1
        ;;
esac

echo -e "${GREEN}✓ Paket türü: $PACKAGE_TYPE${NC}"
echo -e "${GREEN}✓ Hedef dizin: $BASE_PATH${NC}\n"

# Step 2: Ask for package name
echo -e "${YELLOW}[2/3] Paket adını girin (örn: settings, notifications):${NC}"
read -p "Paket adı: " package_name

# Validate package name
if [[ ! "$package_name" =~ ^[a-z][a-z0-9_]*$ ]]; then
    echo -e "${RED}Hata: Paket adı küçük harf, rakam ve alt çizgi içerebilir, harf ile başlamalıdır.${NC}"
    exit 1
fi

# Convert package name to PascalCase for class names
PACKAGE_NAME_PASCAL=$(to_pascal_case "$package_name")

PACKAGE_PATH="$BASE_PATH/$package_name"

# Check if package already exists
if [ -d "$PACKAGE_PATH" ]; then
    echo -e "${RED}Hata: Bu paket zaten mevcut: $PACKAGE_PATH${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Paket adı: $package_name${NC}"
echo -e "${GREEN}✓ Tam path: $PACKAGE_PATH${NC}\n"

# Step 3: Confirm creation
echo -e "${YELLOW}[3/3] Paket oluşturma onayı:${NC}"
echo -e "  Tür     : ${BLUE}$PACKAGE_TYPE${NC}"
echo -e "  İsim    : ${BLUE}$package_name${NC}"
echo -e "  Dizin   : ${BLUE}$PACKAGE_PATH${NC}"
echo ""
read -p "Paketi oluşturmak istediğinize emin misiniz? (y/n): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}İşlem iptal edildi.${NC}"
    exit 0
fi

echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}              Paket Oluşturma Başlıyor...                  ${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"

# Create base package directory
echo -e "${YELLOW}[*] Ana dizin oluşturuluyor...${NC}"
mkdir -p "$PACKAGE_PATH"

# Create basic Flutter package structure
echo -e "${YELLOW}[*] Temel Flutter yapısı oluşturuluyor...${NC}"
mkdir -p "$PACKAGE_PATH/lib"
mkdir -p "$PACKAGE_PATH/test"

# Create pubspec.yaml
echo -e "${YELLOW}[*] pubspec.yaml oluşturuluyor...${NC}"
cat > "$PACKAGE_PATH/pubspec.yaml" << EOF
name: $package_name
description: "A new Flutter package for $package_name."
version: 0.0.1
publish_to: none
resolution: workspace

environment:
  sdk: ^3.9.2
  flutter: ">=1.17.0"

dependencies:
  flutter:
    sdk: flutter

  # Shared packages
  core:
    path: ../../shared/core
  design_system:
    path: ../../shared/design_system
  session:
    path: ../../shared/session

  # Infrastructure packages
  network:
    path: ../../infrastructure/network
  event_bus:
    path: ../../infrastructure/event_bus

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

  # Code Generation
  build_runner: any
  freezed: any
  json_serializable: any
  injectable_generator: any
  auto_route_generator: any

  # Testing
  bloc_test: ^10.0.0
  mocktail: ^1.0.4

EOF
echo -e "${GREEN}✓ pubspec.yaml oluşturuldu${NC}"

# Create analysis_options.yaml
echo -e "${YELLOW}[*] analysis_options.yaml oluşturuluyor...${NC}"
cat > "$PACKAGE_PATH/analysis_options.yaml" << 'EOF'
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_single_quotes: true
    prefer_relative_imports: true
    always_use_package_imports: false
    avoid_print: true
    avoid_unnecessary_containers: true
    avoid_web_libraries_in_flutter: true
    no_logic_in_create_state: true
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    sized_box_for_whitespace: true
    sort_child_properties_last: true
    use_key_in_widget_constructors: true

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.gr.dart"
  errors:
    invalid_annotation_target: ignore
EOF
echo -e "${GREEN}✓ analysis_options.yaml oluşturuldu${NC}"

# Create README.md
echo -e "${YELLOW}[*] README.md oluşturuluyor...${NC}"
cat > "$PACKAGE_PATH/README.md" << EOF
# $package_name

A Flutter package for $package_name feature.

## Features

- Clean Architecture implementation
- BLoC pattern for state management
- Dependency Injection with Injectable
- Type-safe routing with AutoRoute

## Usage

\`\`\`dart
import 'package:$package_name/$package_name.dart';
\`\`\`

## Development

### Code Generation

Run code generation:

\`\`\`bash
cd packages/$PACKAGE_TYPE/$package_name
dart run build_runner build --delete-conflicting-outputs
\`\`\`

Watch mode:

\`\`\`bash
dart run build_runner watch --delete-conflicting-outputs
\`\`\`

### Testing

\`\`\`bash
flutter test
\`\`\`
EOF
echo -e "${GREEN}✓ README.md oluşturuldu${NC}"

# Create LICENSE
echo -e "${YELLOW}[*] LICENSE oluşturuluyor...${NC}"
cat > "$PACKAGE_PATH/LICENSE" << 'EOF'
MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
echo -e "${GREEN}✓ LICENSE oluşturuldu${NC}"

# Create CHANGELOG.md
echo -e "${YELLOW}[*] CHANGELOG.md oluşturuluyor...${NC}"
cat > "$PACKAGE_PATH/CHANGELOG.md" << EOF
# Changelog

All notable changes to this project will be documented in this file.

## [0.0.1] - $(date +%Y-%m-%d)

### Added
- Initial release
- Basic package structure
EOF
echo -e "${GREEN}✓ CHANGELOG.md oluşturuldu${NC}"

# Create .gitignore
echo -e "${YELLOW}[*] .gitignore oluşturuluyor...${NC}"
cat > "$PACKAGE_PATH/.gitignore" << 'EOF'
# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# VS Code
.vscode/

# Flutter/Dart/Pub related
**/doc/api/
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
pubspec.lock

# Code generation
*.g.dart
*.freezed.dart
*.gr.dart

# Coverage
coverage/
EOF
echo -e "${GREEN}✓ .gitignore oluşturuldu${NC}"

# Create .metadata
echo -e "${YELLOW}[*] .metadata oluşturuluyor...${NC}"
cat > "$PACKAGE_PATH/.metadata" << 'EOF'
# This file tracks properties of this Flutter project.
# Used by Flutter tool to assess capabilities and perform upgrades etc.
#
# This file should be version controlled and should not be manually edited.

version:
  revision: 0
  channel: stable

project_type: package
EOF
echo -e "${GREEN}✓ .metadata oluşturuldu${NC}"

# If package type is FEATURE, create Clean Architecture structure
if [ "$PACKAGE_TYPE" = "feature" ]; then
    echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}      Feature Modülü için Clean Architecture yapısı        ${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"

    # Create src directory structure
    echo -e "${YELLOW}[*] src/ klasör yapısı oluşturuluyor...${NC}"

    # Core directories
    mkdir -p "$PACKAGE_PATH/lib/src/core/di"
    mkdir -p "$PACKAGE_PATH/lib/src/core/route"
    mkdir -p "$PACKAGE_PATH/lib/src/core/errors"
    mkdir -p "$PACKAGE_PATH/lib/src/core/utils"

    # Feature directories (Clean Architecture)
    mkdir -p "$PACKAGE_PATH/lib/src/feature/data/datasources"
    mkdir -p "$PACKAGE_PATH/lib/src/feature/data/models"
    mkdir -p "$PACKAGE_PATH/lib/src/feature/data/repositories"
    mkdir -p "$PACKAGE_PATH/lib/src/feature/domain/entities"
    mkdir -p "$PACKAGE_PATH/lib/src/feature/domain/repositories"
    mkdir -p "$PACKAGE_PATH/lib/src/feature/domain/usecases"
    mkdir -p "$PACKAGE_PATH/lib/src/feature/presentation/bloc"
    mkdir -p "$PACKAGE_PATH/lib/src/feature/presentation/pages"
    mkdir -p "$PACKAGE_PATH/lib/src/feature/presentation/widgets"

    echo -e "${GREEN}✓ Klasör yapısı oluşturuldu${NC}"

    # Create barrel export file
    echo -e "${YELLOW}[*] Barrel export dosyası oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/${package_name}.dart" << EOF
library $package_name;

// Core exports
export 'src/core/di/injection.dart';
export 'src/core/route/${package_name}_router.dart';
export 'src/core/route/${package_name}_routes.dart';
export 'src/core/errors/failures.dart';

// Domain exports - Entities
export 'src/feature/domain/entities/example_entity.dart';

// Domain exports - Repositories
export 'src/feature/domain/repositories/example_repository.dart';

// Domain exports - Use Cases
export 'src/feature/domain/usecases/get_example_data_usecase.dart';

// Presentation exports - BLoC
export 'src/feature/presentation/bloc/${package_name}_bloc.dart';

// Presentation exports - Pages
export 'src/feature/presentation/pages/${package_name}_page.dart';
EOF
    echo -e "${GREEN}✓ ${package_name}.dart oluşturuldu${NC}"

    # Create DI files
    echo -e "${YELLOW}[*] Dependency Injection dosyaları oluşturuluyor...${NC}"

    # injection.dart
    cat > "$PACKAGE_PATH/lib/src/core/di/injection.dart" << 'EOF'
import 'package:core/core.dart';

/// Initialize dependency injection for this package
/// This will be called from the root app's DI setup
@InjectableInit.microPackage()
initMicroPackage() {}
EOF

    echo -e "${GREEN}✓ injection.dart oluşturuldu${NC}"

    # Create routing files
    echo -e "${YELLOW}[*] Routing dosyaları oluşturuluyor...${NC}"

    # ${package_name}_router.dart
    cat > "$PACKAGE_PATH/lib/src/core/route/${package_name}_router.dart" << EOF
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

/// Router configuration for $package_name feature
/// Routes are orchestrated by the root app
@AutoRouterConfig(replaceInRouteName: 'Page|View,Route')
@lazySingleton
class $PACKAGE_NAME_PASCALRouter extends RootStackRouter {
  /// Routes will be orchestrated in root app
  /// Empty list - root app handles navigation flow
  @override
  final List<AutoRoute> routes = [];
}
EOF

    # ${package_name}_routes.dart
    cat > "$PACKAGE_PATH/lib/src/core/route/${package_name}_routes.dart" << EOF
/// Route path constants for $package_name feature
/// Used for type-safe navigation across the app
final class $PACKAGE_NAME_PASCALRoutes {
  static $PACKAGE_NAME_PASCALRoutes? _instance;

  /// Singleton factory constructor
  factory $PACKAGE_NAME_PASCALRoutes() => _instance ??= $PACKAGE_NAME_PASCALRoutes._();

  /// Private constructor
  $PACKAGE_NAME_PASCALRoutes._();

  /// Main route for $package_name
  String get main => '/$package_name';

  /// Add more routes here as needed
  /// Example:
  /// String get details => '/$package_name/details';
}
EOF

    echo -e "${GREEN}✓ Routing dosyaları oluşturuldu${NC}"

    # Create failures.dart
    echo -e "${YELLOW}[*] Failure hierarchy dosyası oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/core/errors/failures.dart" << EOF
import 'package:equatable/equatable.dart';

/// Base class for all failures in the $package_name feature
abstract class Failure extends Equatable {
  /// Error message
  final String message;

  /// Optional error code
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Server error failure
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Network connection failure
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

/// Cache/Local storage failure
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Input validation failure
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

/// Feature-specific failure
class $PACKAGE_NAME_PASCALFailure extends Failure {
  const $PACKAGE_NAME_PASCALFailure({required super.message, super.code});
}

/// Unauthorized access failure
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message, super.code});
}
EOF
    echo -e "${GREEN}✓ failures.dart oluşturuldu${NC}"

    # Create example entity
    echo -e "${YELLOW}[*] Örnek Entity oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/feature/domain/entities/example_entity.dart" << 'EOF'
import 'package:equatable/equatable.dart';

/// Example entity representing a domain object
/// This is a pure Dart class with no external dependencies
class ExampleEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ExampleEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, description, createdAt, updatedAt];

  @override
  String toString() {
    return 'ExampleEntity(id: $id, name: $name, description: $description)';
  }

  /// Example business logic method
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inDays < 7;
  }
}
EOF
    echo -e "${GREEN}✓ example_entity.dart oluşturuldu${NC}"

    # Create example repository interface
    echo -e "${YELLOW}[*] Örnek Repository interface oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/feature/domain/repositories/example_repository.dart" << 'EOF'
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/example_entity.dart';

/// Example repository interface
/// Defines the contract for data operations
abstract class ExampleRepository {
  /// Get example data by id
  /// Returns [Right(ExampleEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, ExampleEntity>> getExampleById({
    required String id,
  });

  /// Get all example data
  /// Returns [Right(List<ExampleEntity>)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, List<ExampleEntity>>> getAllExamples();

  /// Create new example data
  /// Returns [Right(ExampleEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, ExampleEntity>> createExample({
    required String name,
    required String description,
  });

  /// Update example data
  /// Returns [Right(ExampleEntity)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, ExampleEntity>> updateExample({
    required String id,
    required String name,
    required String description,
  });

  /// Delete example data
  /// Returns [Right(Unit)] on success
  /// Returns [Left(Failure)] on failure
  Future<Either<Failure, Unit>> deleteExample({required String id});
}
EOF
    echo -e "${GREEN}✓ example_repository.dart oluşturuldu${NC}"

    # Create example usecase
    echo -e "${YELLOW}[*] Örnek UseCase oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/feature/domain/usecases/get_example_data_usecase.dart" << 'EOF'
import 'package:core/core.dart';

import '../../../core/errors/failures.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repository.dart';

/// Use case for getting example data
/// Demonstrates the use case pattern with validation and business logic
@injectable
class GetExampleDataUseCase
    implements UseCase<ExampleEntity, GetExampleDataParams, Failure> {
  final ExampleRepository repository;

  GetExampleDataUseCase(this.repository);

  @override
  Future<Either<Failure, ExampleEntity>> call(
      GetExampleDataParams params) async {
    // Validate input
    if (params.id.isEmpty) {
      return const Left(
        ValidationFailure(
          message: 'ID cannot be empty',
          code: 'INVALID_ID',
        ),
      );
    }

    // Call repository to fetch data
    final result = await repository.getExampleById(id: params.id);

    // Apply business logic if needed
    return result.fold(
      (failure) => Left(failure),
      (entity) {
        // Example: Check if data is recent
        if (entity.isRecent) {
          // Could publish an event here if needed
          // EventBus.instance.publish(RecentDataFoundEvent(entity));
        }
        return Right(entity);
      },
    );
  }
}

/// Parameters for GetExampleDataUseCase
class GetExampleDataParams extends Equatable {
  final String id;

  const GetExampleDataParams({required this.id});

  @override
  List<Object?> get props => [id];
}
EOF
    echo -e "${GREEN}✓ get_example_data_usecase.dart oluşturuldu${NC}"

    # Create Data Layer files
    echo -e "\n${YELLOW}[*] Data Layer dosyaları oluşturuluyor...${NC}"

    # Create example model (Freezed + Wrapper pattern)
    echo -e "${YELLOW}[*] Örnek Model oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/feature/data/models/example_model.dart" << 'EOF'
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/example_entity.dart';

part 'example_model.freezed.dart';
part 'example_model.g.dart';

/// Example model wrapper
/// Wraps the freezed model and provides entity conversion
class ExampleModel {
  final ExampleModelData data;

  const ExampleModel(this.data);

  /// Convert model to entity
  ExampleEntity toEntity() {
    return ExampleEntity(
      id: data.id,
      name: data.name,
      description: data.description,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  /// Create model from entity
  factory ExampleModel.fromEntity(ExampleEntity entity) {
    return ExampleModel(
      ExampleModelData(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      ),
    );
  }

  /// Create model from JSON
  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(ExampleModelData.fromJson(json));
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() => data.toJson();
}

/// Example model data with freezed
/// Handles JSON serialization and immutability
@freezed
abstract class ExampleModelData with _$ExampleModelData {
  const factory ExampleModelData({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ExampleModelData;

  factory ExampleModelData.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelDataFromJson(json);
}
EOF
    echo -e "${GREEN}✓ example_model.dart oluşturuldu${NC}"

    # Create local datasource
    echo -e "${YELLOW}[*] Local DataSource oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/feature/data/datasources/example_local_datasource.dart" << 'EOF'
import 'package:injectable/injectable.dart';
import 'package:storage/storage.dart';

import '../models/example_model.dart';

/// Local data source interface for example data
/// Handles local storage operations
abstract class ExampleLocalDataSource {
  /// Save example data to local storage
  Future<void> saveExample(ExampleModel example);

  /// Get example data by id from local storage
  Future<ExampleModel?> getExampleById(String id);

  /// Get all example data from local storage
  Future<List<ExampleModel>> getAllExamples();

  /// Delete example data from local storage
  Future<void> deleteExample(String id);

  /// Clear all example data
  Future<void> clearAll();
}

/// Implementation of ExampleLocalDataSource
/// Uses StorageHelper for local persistence
@LazySingleton(as: ExampleLocalDataSource)
class ExampleLocalDataSourceImpl implements ExampleLocalDataSource {
  // TODO: Uncomment when storage DB model is created
  // late final StorageHelper<ExampleDbModel> _storage;
  //
  // ExampleLocalDataSourceImpl(this._storage);

  @override
  Future<void> saveExample(ExampleModel example) async {
    // TODO: Implement storage save
    // final dbModel = ExampleDbModel(
    //   id: example.data.id,
    //   name: example.data.name,
    //   description: example.data.description,
    //   createdAt: example.data.createdAt,
    //   updatedAt: example.data.updatedAt,
    // );
    // await _storage.save(dbModel);
  }

  @override
  Future<ExampleModel?> getExampleById(String id) async {
    // TODO: Implement storage retrieval by id
    // final dbModel = await _storage.findById(id);
    // if (dbModel == null) return null;
    //
    // return ExampleModel(
    //   ExampleModelData(
    //     id: dbModel.id,
    //     name: dbModel.name,
    //     description: dbModel.description,
    //     createdAt: dbModel.createdAt,
    //     updatedAt: dbModel.updatedAt,
    //   ),
    // );
    return null;
  }

  @override
  Future<List<ExampleModel>> getAllExamples() async {
    // TODO: Implement get all from storage
    // final dbModels = await _storage.findAll();
    // return dbModels
    //     .map((dbModel) => ExampleModel(
    //           ExampleModelData(
    //             id: dbModel.id,
    //             name: dbModel.name,
    //             description: dbModel.description,
    //             createdAt: dbModel.createdAt,
    //             updatedAt: dbModel.updatedAt,
    //           ),
    //         ))
    //     .toList();
    return [];
  }

  @override
  Future<void> deleteExample(String id) async {
    // TODO: Implement storage deletion
    // await _storage.deleteById(id);
  }

  @override
  Future<void> clearAll() async {
    // TODO: Implement clear all
    // await _storage.deleteAll();
  }
}
EOF
    echo -e "${GREEN}✓ example_local_datasource.dart oluşturuldu${NC}"

    # Create remote datasource
    echo -e "${YELLOW}[*] Remote DataSource oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/feature/data/datasources/example_remote_datasource.dart" << 'EOF'
import 'package:config/config.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

import '../models/example_model.dart';

/// Remote data source interface for example data
/// Handles API calls for example operations
abstract class ExampleRemoteDataSource {
  /// Get example data by id from API
  Future<ExampleModel> getExampleById(String id);

  /// Get all example data from API
  Future<List<ExampleModel>> getAllExamples();

  /// Create new example data on server
  Future<ExampleModel> createExample({
    required String name,
    required String description,
  });

  /// Update existing example data on server
  Future<ExampleModel> updateExample({
    required String id,
    required String name,
    required String description,
  });

  /// Delete example data from server
  Future<void> deleteExample(String id);
}

/// Implementation of ExampleRemoteDataSource
/// Uses HttpClient for API communication
@LazySingleton(as: ExampleRemoteDataSource)
class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
  final HttpClient httpClient;

  ExampleRemoteDataSourceImpl(this.httpClient);

  @override
  Future<ExampleModel> getExampleById(String id) async {
    try {
      // TODO: Replace with actual API endpoint
      final response = await httpClient.get('/examples/$id');
      return ExampleModel.fromJson(response.data);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(
        message: 'Failed to parse example data',
      );
    }
  }

  @override
  Future<List<ExampleModel>> getAllExamples() async {
    try {
      // TODO: Replace with actual API endpoint
      final response = await httpClient.get('/examples');
      final List<dynamic> data = response.data;
      return data.map((json) => ExampleModel.fromJson(json)).toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(
        message: 'Failed to parse examples list',
      );
    }
  }

  @override
  Future<ExampleModel> createExample({
    required String name,
    required String description,
  }) async {
    try {
      // TODO: Replace with actual API endpoint
      final response = await httpClient.post(
        '/examples',
        data: {
          'name': name,
          'description': description,
        },
      );
      return ExampleModel.fromJson(response.data);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(
        message: 'Failed to create example',
      );
    }
  }

  @override
  Future<ExampleModel> updateExample({
    required String id,
    required String name,
    required String description,
  }) async {
    try {
      // TODO: Replace with actual API endpoint
      final response = await httpClient.put(
        '/examples/$id',
        data: {
          'name': name,
          'description': description,
        },
      );
      return ExampleModel.fromJson(response.data);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const ParseException(
        message: 'Failed to update example',
      );
    }
  }

  @override
  Future<void> deleteExample(String id) async {
    try {
      // TODO: Replace with actual API endpoint
      await httpClient.delete('/examples/$id');
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw const UnknownException(
        message: 'Failed to delete example',
      );
    }
  }
}
EOF
    echo -e "${GREEN}✓ example_remote_datasource.dart oluşturuldu${NC}"

    # Create repository implementation
    echo -e "${YELLOW}[*] Repository Implementation oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/feature/data/repositories/example_repository_impl.dart" << 'EOF'
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

import '../../../core/errors/failures.dart';
import '../../domain/entities/example_entity.dart';
import '../../domain/repositories/example_repository.dart';
import '../datasources/example_local_datasource.dart';
import '../datasources/example_remote_datasource.dart';

/// Implementation of ExampleRepository
/// Orchestrates data flow between remote and local data sources
@LazySingleton(as: ExampleRepository)
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDataSource remoteDataSource;
  final ExampleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ExampleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ExampleEntity>> getExampleById({
    required String id,
  }) async {
    // Try to get from local storage first
    try {
      final cachedExample = await localDataSource.getExampleById(id);
      if (cachedExample != null) {
        return Right(cachedExample.toEntity());
      }
    } catch (e) {
      // Continue to fetch from remote
    }

    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      final exampleModel = await remoteDataSource.getExampleById(id);

      // Save to local storage for caching
      await localDataSource.saveExample(exampleModel);

      return Right(exampleModel.toEntity());
    } on NotFoundException catch (e) {
      return Left(
        ValidationFailure(
          message: e.message,
          code: 'NOT_FOUND',
        ),
      );
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to get example data',
          code: 'GET_EXAMPLE_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ExampleEntity>>> getAllExamples() async {
    // Try to get from local storage first
    try {
      final cachedExamples = await localDataSource.getAllExamples();
      if (cachedExamples.isNotEmpty) {
        return Right(
          cachedExamples.map((model) => model.toEntity()).toList(),
        );
      }
    } catch (e) {
      // Continue to fetch from remote
    }

    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      final exampleModels = await remoteDataSource.getAllExamples();

      // Save to local storage for caching
      for (var model in exampleModels) {
        await localDataSource.saveExample(model);
      }

      return Right(
        exampleModels.map((model) => model.toEntity()).toList(),
      );
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to get all examples',
          code: 'GET_ALL_EXAMPLES_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ExampleEntity>> createExample({
    required String name,
    required String description,
  }) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      final exampleModel = await remoteDataSource.createExample(
        name: name,
        description: description,
      );

      // Save to local storage
      await localDataSource.saveExample(exampleModel);

      return Right(exampleModel.toEntity());
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to create example',
          code: 'CREATE_EXAMPLE_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ExampleEntity>> updateExample({
    required String id,
    required String name,
    required String description,
  }) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      final exampleModel = await remoteDataSource.updateExample(
        id: id,
        name: name,
        description: description,
      );

      // Update local storage
      await localDataSource.saveExample(exampleModel);

      return Right(exampleModel.toEntity());
    } on NotFoundException catch (e) {
      return Left(
        ValidationFailure(
          message: e.message,
          code: 'NOT_FOUND',
        ),
      );
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to update example',
          code: 'UPDATE_EXAMPLE_FAILED',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteExample({required String id}) async {
    // Check network connectivity
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        ),
      );
    }

    try {
      await remoteDataSource.deleteExample(id);

      // Delete from local storage
      await localDataSource.deleteExample(id);

      return const Right(unit);
    } on NotFoundException catch (e) {
      return Left(
        ValidationFailure(
          message: e.message,
          code: 'NOT_FOUND',
        ),
      );
    } on NetworkException catch (e) {
      return Left(
        NetworkFailure(
          message: e.message,
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Failed to delete example',
          code: 'DELETE_EXAMPLE_FAILED',
        ),
      );
    }
  }
}
EOF
    echo -e "${GREEN}✓ example_repository_impl.dart oluşturuldu${NC}"

    # Create BLoC files
    echo -e "${YELLOW}[*] BLoC dosyaları oluşturuluyor...${NC}"

    # ${package_name}_bloc.dart
    cat > "$PACKAGE_PATH/lib/src/feature/presentation/bloc/${package_name}_bloc.dart" << EOF
import 'package:core/core.dart';

import '../../domain/usecases/get_example_data_usecase.dart';
import '../../domain/entities/example_entity.dart';

part '${package_name}_event.dart';
part '${package_name}_state.dart';
part '${package_name}_bloc.freezed.dart';

/// BLoC for $package_name feature
/// Manages state and handles business logic through use cases
@lazySingleton
class $PACKAGE_NAME_PASCALBloc extends Bloc<$PACKAGE_NAME_PASCALEvent, $PACKAGE_NAME_PASCALState> {
  // Inject use cases
  final GetExampleDataUseCase getExampleDataUseCase;

  $PACKAGE_NAME_PASCALBloc({
    required this.getExampleDataUseCase,
  }) : super(const $PACKAGE_NAME_PASCALState.initial()) {
    // Register event handlers
    on<$PACKAGE_NAME_PASCALEventLoadData>(_onLoadData);
  }

  /// Handle load data event
  Future<void> _onLoadData(
    $PACKAGE_NAME_PASCALEventLoadData event,
    Emitter<$PACKAGE_NAME_PASCALState> emit,
  ) async {
    emit(const $PACKAGE_NAME_PASCALState.loading());

    // Call use case with parameters
    final params = GetExampleDataParams(id: event.id);
    final result = await getExampleDataUseCase(params);

    // Handle result
    result.fold(
      (failure) {
        // Emit error state on failure
        emit($PACKAGE_NAME_PASCALState.error(failure.message));
      },
      (entity) {
        // Emit success state with data
        emit($PACKAGE_NAME_PASCALState.loaded(entity));
      },
    );
  }
}
EOF

    # ${package_name}_event.dart
    cat > "$PACKAGE_PATH/lib/src/feature/presentation/bloc/${package_name}_event.dart" << EOF
part of '${package_name}_bloc.dart';

/// Events for $package_name feature
@freezed
abstract class $PACKAGE_NAME_PASCALEvent with _\$$PACKAGE_NAME_PASCALEvent {
  /// Load data event
  const factory $PACKAGE_NAME_PASCALEvent.loadData({required String id}) =
      $PACKAGE_NAME_PASCALEventLoadData;

  /// Add more events here as needed
  /// Example:
  /// const factory $PACKAGE_NAME_PASCALEvent.refresh() = $PACKAGE_NAME_PASCALEventRefresh;
  /// const factory $PACKAGE_NAME_PASCALEvent.delete({required String id}) = $PACKAGE_NAME_PASCALEventDelete;
}
EOF

    # ${package_name}_state.dart
    cat > "$PACKAGE_PATH/lib/src/feature/presentation/bloc/${package_name}_state.dart" << EOF
part of '${package_name}_bloc.dart';

/// States for $package_name feature
@freezed
class $PACKAGE_NAME_PASCALState with _\$$PACKAGE_NAME_PASCALState {
  /// Initial state - no data loaded yet
  const factory $PACKAGE_NAME_PASCALState.initial() = $PACKAGE_NAME_PASCALStateInitial;

  /// Loading state - data is being fetched
  const factory $PACKAGE_NAME_PASCALState.loading() = $PACKAGE_NAME_PASCALStateLoading;

  /// Loaded state - data successfully fetched
  const factory $PACKAGE_NAME_PASCALState.loaded(ExampleEntity data) =
      $PACKAGE_NAME_PASCALStateLoaded;

  /// Error state - something went wrong
  const factory $PACKAGE_NAME_PASCALState.error(String message) =
      $PACKAGE_NAME_PASCALStateError;
}
EOF

    echo -e "${GREEN}✓ BLoC dosyaları oluşturuldu${NC}"

    # Create main page
    echo -e "${YELLOW}[*] Ana sayfa oluşturuluyor...${NC}"
    cat > "$PACKAGE_PATH/lib/src/feature/presentation/pages/${package_name}_page.dart" << EOF
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

import '../bloc/${package_name}_bloc.dart';

/// Main page for $package_name feature
/// Demonstrates BLoC integration and state management
@RoutePage()
class $PACKAGE_NAME_PASCALPage extends StatefulWidget {
  const $PACKAGE_NAME_PASCALPage({super.key});

  @override
  State<$PACKAGE_NAME_PASCALPage> createState() => _$PACKAGE_NAME_PASCALPageState();
}

class _$PACKAGE_NAME_PASCALPageState extends State<$PACKAGE_NAME_PASCALPage> {
  @override
  void initState() {
    super.initState();
    // Load data when page initializes
    // Example: Load data with ID "1"
    context.read<$PACKAGE_NAME_PASCALBloc>().add(
          const $PACKAGE_NAME_PASCALEvent.loadData(id: '1'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$PACKAGE_NAME_PASCAL'.replaceAll('_', ' ')),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reload data
              context.read<$PACKAGE_NAME_PASCALBloc>().add(
                    const $PACKAGE_NAME_PASCALEvent.loadData(id: '1'),
                  );
            },
          ),
        ],
      ),
      body: BlocConsumer<$PACKAGE_NAME_PASCALBloc, $PACKAGE_NAME_PASCALState>(
        listener: (context, state) {
          // Handle state changes that need side effects (e.g., show snackbar)
          state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
            // Initial state - show prompt to load data
            initial: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ready to load data',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Load Example Data',
                    onPressed: () {
                      context.read<$PACKAGE_NAME_PASCALBloc>().add(
                            const $PACKAGE_NAME_PASCALEvent.loadData(id: '1'),
                          );
                    },
                  ),
                ],
              ),
            ),
            // Loading state - show progress indicator
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            // Loaded state - show data
            loaded: (data) => Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Example Data',
                            style: AppTypographyResponsive.headlineSmall,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const Divider(),
                          const SizedBox(height: AppSpacing.sm),
                          _buildDataRow('ID', data.id),
                          _buildDataRow('Name', data.name),
                          _buildDataRow('Description', data.description),
                          _buildDataRow(
                            'Created At',
                            data.createdAt.toString().split('.')[0],
                          ),
                          if (data.updatedAt != null)
                            _buildDataRow(
                              'Updated At',
                              data.updatedAt.toString().split('.')[0],
                            ),
                          _buildDataRow(
                            'Is Recent',
                            data.isRecent ? 'Yes' : 'No',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Reload Data',
                    onPressed: () {
                      context.read<$PACKAGE_NAME_PASCALBloc>().add(
                            const $PACKAGE_NAME_PASCALEvent.loadData(id: '1'),
                          );
                    },
                  ),
                ],
              ),
            ),
            // Error state - show error message with retry button
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Error',
                      style: AppTypographyResponsive.headlineSmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      label: 'Retry',
                      onPressed: () {
                        context.read<$PACKAGE_NAME_PASCALBloc>().add(
                              const $PACKAGE_NAME_PASCALEvent.loadData(id: '1'),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Helper widget to build data rows
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '\$label:',
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
EOF
    echo -e "${GREEN}✓ ${package_name}_page.dart oluşturuldu${NC}"

    # Create test file
    echo -e "${YELLOW}[*] Test dosyası oluşturuluyor...${NC}"
    mkdir -p "$PACKAGE_PATH/test/src/feature/presentation/bloc"
    cat > "$PACKAGE_PATH/test/src/feature/presentation/bloc/${package_name}_bloc_test.dart" << EOF
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:$package_name/$package_name.dart';
import 'package:$package_name/src/feature/domain/usecases/get_example_data_usecase.dart';
import 'package:$package_name/src/feature/domain/entities/example_entity.dart';

// Mock classes
class MockGetExampleDataUseCase extends Mock
    implements GetExampleDataUseCase {}

void main() {
  group('$PACKAGE_NAME_PASCALBloc', () {
    late $PACKAGE_NAME_PASCALBloc bloc;
    late MockGetExampleDataUseCase mockGetExampleDataUseCase;

    // Sample test data
    final testEntity = ExampleEntity(
      id: '1',
      name: 'Test Name',
      description: 'Test Description',
      createdAt: DateTime.now(),
    );

    setUp(() {
      // Initialize mocks
      mockGetExampleDataUseCase = MockGetExampleDataUseCase();

      // Create bloc with mocked dependencies
      bloc = $PACKAGE_NAME_PASCALBloc(
        getExampleDataUseCase: mockGetExampleDataUseCase,
      );

      // Register fallback values for Mocktail
      registerFallbackValue(const GetExampleDataParams(id: ''));
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is $PACKAGE_NAME_PASCALStateInitial', () {
      expect(bloc.state, const $PACKAGE_NAME_PASCALState.initial());
    });

    group('LoadData', () {
      blocTest<$PACKAGE_NAME_PASCALBloc, $PACKAGE_NAME_PASCALState>(
        'emits [loading, loaded] when data is loaded successfully',
        build: () {
          // Mock successful response
          when(() => mockGetExampleDataUseCase(any()))
              .thenAnswer((_) async => Right(testEntity));
          return bloc;
        },
        act: (bloc) => bloc.add(const $PACKAGE_NAME_PASCALEvent.loadData(id: '1')),
        expect: () => [
          const $PACKAGE_NAME_PASCALState.loading(),
          $PACKAGE_NAME_PASCALState.loaded(testEntity),
        ],
        verify: (_) {
          // Verify use case was called with correct params
          verify(
            () => mockGetExampleDataUseCase(
              const GetExampleDataParams(id: '1'),
            ),
          ).called(1);
        },
      );

      blocTest<$PACKAGE_NAME_PASCALBloc, $PACKAGE_NAME_PASCALState>(
        'emits [loading, error] when data loading fails',
        build: () {
          // Mock failure response
          when(() => mockGetExampleDataUseCase(any())).thenAnswer(
            (_) async => const Left(
              ServerFailure(
                message: 'Server error',
                code: 'SERVER_ERROR',
              ),
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const $PACKAGE_NAME_PASCALEvent.loadData(id: '1')),
        expect: () => [
          const $PACKAGE_NAME_PASCALState.loading(),
          const $PACKAGE_NAME_PASCALState.error('Server error'),
        ],
      );

      blocTest<$PACKAGE_NAME_PASCALBloc, $PACKAGE_NAME_PASCALState>(
        'emits [loading, error] when validation fails',
        build: () {
          // Mock validation failure
          when(() => mockGetExampleDataUseCase(any())).thenAnswer(
            (_) async => const Left(
              ValidationFailure(
                message: 'ID cannot be empty',
                code: 'INVALID_ID',
              ),
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const $PACKAGE_NAME_PASCALEvent.loadData(id: '')),
        expect: () => [
          const $PACKAGE_NAME_PASCALState.loading(),
          const $PACKAGE_NAME_PASCALState.error('ID cannot be empty'),
        ],
      );
    });
  });
}
EOF
    echo -e "${GREEN}✓ Test dosyası oluşturuldu${NC}"

fi

echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}                  Paket Başarıyla Oluşturuldu!             ${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"

echo -e "${GREEN}✓ Paket: $package_name${NC}"
echo -e "${GREEN}✓ Dizin: $PACKAGE_PATH${NC}\n"

# Show next steps
echo -e "${YELLOW}Sonraki Adımlar:${NC}\n"

if [ "$PACKAGE_TYPE" = "feature" ]; then
    echo -e "1. ${BLUE}Code generation çalıştırın:${NC}"
    echo -e "   cd $PACKAGE_PATH"
    echo -e "   dart run build_runner build --delete-conflicting-outputs\n"

    echo -e "2. ${BLUE}Root app'e feature'ı ekleyin:${NC}"
    echo -e "   - app/root/pubspec.yaml → dependencies altına ekleyin"
    echo -e "   - app/root/lib/core/di/injection_container.dart → ExternalModule ekleyin"
    echo -e "   - app/root/lib/core/route/app_router.dart → Route'u ekleyin"
    echo -e "   - app/root/lib/core/event/app_event_listener.dart → Event listener ekleyin\n"

    echo -e "3. ${BLUE}Use case ve entity'leri implement edin${NC}\n"

    echo -e "4. ${BLUE}Datasource ve repository'leri implement edin${NC}\n"

    echo -e "5. ${BLUE}BLoC logic'i tamamlayın${NC}\n"

    echo -e "6. ${BLUE}UI sayfalarını geliştirin${NC}\n"

    echo -e "7. ${BLUE}Test'leri yazın ve çalıştırın:${NC}"
    echo -e "   melos run test --scope=$package_name\n"
else
    echo -e "1. ${BLUE}Package implementation'ı tamamlayın${NC}\n"

    echo -e "2. ${BLUE}Gerekli dependency'leri kullanacak paketlere ekleyin${NC}\n"

    echo -e "3. ${BLUE}Test'leri yazın ve çalıştırın:${NC}"
    echo -e "   cd $PACKAGE_PATH"
    echo -e "   flutter test\n"
fi

echo -e "${YELLOW}Melos ile bootstrap çalıştırmayı unutmayın:${NC}"
echo -e "  melos bootstrap\n"

echo -e "${GREEN}Başarılar! 🚀${NC}\n"
