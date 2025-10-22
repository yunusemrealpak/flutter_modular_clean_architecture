#!/bin/bash

# Script to create new packages (Feature/Shared/Infrastructure)
# Uses templates from scripts/templates/

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
source "$SCRIPT_DIR/../common/functions.sh"

# Get project root and templates directory
PROJECT_ROOT=$(get_project_root)
TEMPLATES_DIR="$SCRIPT_DIR/../templates"

# Main function
main() {
    print_header "Create New Package"

    # Step 1: Select package type
    echo -e "${CYAN}Select package type:${NC}\n"
    echo -e "${GREEN}1)${NC} Feature Package"
    echo -e "${GREEN}2)${NC} Shared Package"
    echo -e "${GREEN}3)${NC} Infrastructure Package"
    echo ""

    read -p "Enter choice (1-3): " package_type_choice

    case $package_type_choice in
        1)
            PACKAGE_TYPE="feature"
            PACKAGES_DIR="$PROJECT_ROOT/packages/features"
            ;;
        2)
            PACKAGE_TYPE="shared"
            PACKAGES_DIR="$PROJECT_ROOT/packages/shared"
            ;;
        3)
            PACKAGE_TYPE="infrastructure"
            PACKAGES_DIR="$PROJECT_ROOT/packages/infrastructure"
            ;;
        *)
            print_error "Invalid choice!"
            exit 1
            ;;
    esac

    print_success "Package type: $PACKAGE_TYPE"
    echo ""

    # Step 2: Get package name
    while true; do
        read -p "Enter package name (snake_case): " package_name

        if validate_package_name "$package_name"; then
            break
        else
            print_error "Invalid package name! Use lowercase letters, numbers, and underscores only."
            print_info "Example: vehicle_acceptance, user_profile, auth"
        fi
    done

    # Convert to PascalCase
    PACKAGE_NAME_PASCAL=$(to_pascal_case "$package_name")

    print_success "Package name: $package_name"
    print_success "PascalCase name: $PACKAGE_NAME_PASCAL"
    echo ""

    # Step 3: Check if package already exists
    PACKAGE_PATH="$PACKAGES_DIR/$package_name"

    if package_exists "$PACKAGE_PATH"; then
        print_error "Package already exists at: $PACKAGE_PATH"
        exit 1
    fi

    # Step 4: Show summary and confirm
    print_header "Package Summary"
    echo -e "${CYAN}Type:${NC} $PACKAGE_TYPE"
    echo -e "${CYAN}Name:${NC} $package_name"
    echo -e "${CYAN}PascalCase:${NC} $PACKAGE_NAME_PASCAL"
    echo -e "${CYAN}Path:${NC} $PACKAGE_PATH"
    echo ""

    if ! confirm_action "Create this package?"; then
        print_warning "Package creation cancelled."
        exit 0
    fi

    # Step 5: Create package structure based on type
    case $PACKAGE_TYPE in
        feature)
            create_feature_package "$PACKAGE_PATH" "$package_name" "$PACKAGE_NAME_PASCAL"
            ;;
        shared)
            create_shared_package "$PACKAGE_PATH" "$package_name" "$PACKAGE_NAME_PASCAL"
            ;;
        infrastructure)
            create_infrastructure_package "$PACKAGE_PATH" "$package_name" "$PACKAGE_NAME_PASCAL"
            ;;
    esac

    # Step 6: Success message and next steps
    print_header "Package Created Successfully!"

    echo -e "${GREEN}✓${NC} Package structure created at: ${CYAN}$PACKAGE_PATH${NC}"
    echo ""

    print_step "Next steps:"
    echo "1. Run code generation:"
    echo -e "   ${BLUE}cd $PACKAGE_PATH${NC}"
    echo -e "   ${BLUE}dart run build_runner build --delete-conflicting-outputs${NC}"
    echo ""
    echo "2. Add package to your app's pubspec.yaml:"
    echo -e "   ${BLUE}$package_name:${NC}"
    echo -e "   ${BLUE}  path: ../packages/${PACKAGE_TYPE}s/$package_name${NC}"
    echo ""

    if [ "$PACKAGE_TYPE" = "feature" ]; then
        echo "3. Add DI module to root app's injection_container.dart:"
        echo -e "   ${BLUE}ExternalModule(${PACKAGE_NAME_PASCAL}PackageModule)${NC}"
        echo ""
        echo "4. Add routes to root app's app_router.dart"
        echo ""
    fi
}

# Create feature package structure
create_feature_package() {
    local package_path="$1"
    local package_name="$2"
    local package_name_pascal="$3"

    print_step "Creating feature package structure..."

    # Create directory structure
    mkdir -p "$package_path/lib/src/"{core/{di,route,errors},feature/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{bloc,pages}}}
    mkdir -p "$package_path/test/src/feature/presentation/bloc"

    # Create files from templates
    print_step "Generating files from templates..."

    # Root files
    create_from_template \
        "$TEMPLATES_DIR/feature/pubspec.yaml.template" \
        "$package_path/pubspec.yaml" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/barrel.dart.template" \
        "$package_path/lib/${package_name}.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    # Core files
    create_from_template \
        "$TEMPLATES_DIR/feature/core/injection.dart.template" \
        "$package_path/lib/src/core/di/injection.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/core/router.dart.template" \
        "$package_path/lib/src/core/route/${package_name}_router.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/core/routes.dart.template" \
        "$package_path/lib/src/core/route/${package_name}_routes.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/core/failures.dart.template" \
        "$package_path/lib/src/core/errors/failures.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    # Domain files
    create_from_template \
        "$TEMPLATES_DIR/feature/domain/entity.dart.template" \
        "$package_path/lib/src/feature/domain/entities/example_entity.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/domain/repository.dart.template" \
        "$package_path/lib/src/feature/domain/repositories/example_repository.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/domain/usecase.dart.template" \
        "$package_path/lib/src/feature/domain/usecases/get_example_data_usecase.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    # Data files
    create_from_template \
        "$TEMPLATES_DIR/feature/data/model.dart.template" \
        "$package_path/lib/src/feature/data/models/example_model.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/data/local_datasource.dart.template" \
        "$package_path/lib/src/feature/data/datasources/example_local_datasource.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/data/remote_datasource.dart.template" \
        "$package_path/lib/src/feature/data/datasources/example_remote_datasource.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/data/repository_impl.dart.template" \
        "$package_path/lib/src/feature/data/repositories/example_repository_impl.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    # Presentation files
    create_from_template \
        "$TEMPLATES_DIR/feature/presentation/bloc.dart.template" \
        "$package_path/lib/src/feature/presentation/bloc/${package_name}_bloc.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/presentation/event.dart.template" \
        "$package_path/lib/src/feature/presentation/bloc/${package_name}_event.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/presentation/state.dart.template" \
        "$package_path/lib/src/feature/presentation/bloc/${package_name}_state.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    create_from_template \
        "$TEMPLATES_DIR/feature/presentation/page.dart.template" \
        "$package_path/lib/src/feature/presentation/pages/${package_name}_page.dart" \
        "PACKAGE_NAME=$package_name" \
        "PACKAGE_NAME_PASCAL=$package_name_pascal"

    # Create analysis_options.yaml
    cat > "$package_path/analysis_options.yaml" << 'EOF'
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.gr.dart"
    - "**/*.config.dart"
  errors:
    invalid_annotation_target: ignore
EOF

    # Create README
    cat > "$package_path/README.md" << EOF
# $package_name

${package_name_pascal} feature package for the application.

## Structure

This package follows Clean Architecture principles:

- **Domain Layer**: Business entities, repository interfaces, and use cases
- **Data Layer**: Repository implementations, data sources, and models
- **Presentation Layer**: BLoC, pages, and widgets

## Usage

Add to your \`pubspec.yaml\`:

\`\`\`yaml
dependencies:
  $package_name:
    path: ../packages/features/$package_name
\`\`\`

## Code Generation

Run code generation after making changes:

\`\`\`bash
dart run build_runner build --delete-conflicting-outputs
\`\`\`
EOF

    print_success "Feature package structure created!"
}

# Create shared package structure
create_shared_package() {
    local package_path="$1"
    local package_name="$2"
    local package_name_pascal="$3"

    print_step "Creating shared package structure..."

    mkdir -p "$package_path/lib/src"
    mkdir -p "$package_path/test"

    # Create pubspec.yaml
    cat > "$package_path/pubspec.yaml" << EOF
name: $package_name
description: ${package_name_pascal} shared package
version: 0.0.1
publish_to: none

environment:
  sdk: ^3.6.1

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
EOF

    # Create barrel file
    cat > "$package_path/lib/${package_name}.dart" << EOF
library $package_name;

// Export your utilities here
EOF

    # Create README
    cat > "$package_path/README.md" << EOF
# $package_name

${package_name_pascal} shared utility package.

## Usage

Add to your \`pubspec.yaml\`:

\`\`\`yaml
dependencies:
  $package_name:
    path: ../packages/shared/$package_name
\`\`\`
EOF

    print_success "Shared package structure created!"
}

# Create infrastructure package structure
create_infrastructure_package() {
    local package_path="$1"
    local package_name="$2"
    local package_name_pascal="$3"

    print_step "Creating infrastructure package structure..."

    mkdir -p "$package_path/lib/src"
    mkdir -p "$package_path/test"

    # Create pubspec.yaml
    cat > "$package_path/pubspec.yaml" << EOF
name: $package_name
description: ${package_name_pascal} infrastructure package
version: 0.0.1
publish_to: none

environment:
  sdk: ^3.6.1

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
EOF

    # Create barrel file
    cat > "$package_path/lib/${package_name}.dart" << EOF
library $package_name;

// Export your services here
EOF

    # Create README
    cat > "$package_path/README.md" << EOF
# $package_name

${package_name_pascal} infrastructure service package.

## Usage

Add to your \`pubspec.yaml\`:

\`\`\`yaml
dependencies:
  $package_name:
    path: ../packages/infrastructure/$package_name
\`\`\`
EOF

    print_success "Infrastructure package structure created!"
}

# Run main function
main
