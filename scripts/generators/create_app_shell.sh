#!/bin/bash

# Script to create App Shell feature with bottom navigation

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
source "$SCRIPT_DIR/../common/functions.sh"

# Get project root
PROJECT_ROOT=$(get_project_root)

print_header "App Shell Generator - Bottom Navigation Setup"

# Check if app_shell already exists
APP_SHELL_PATH="$PROJECT_ROOT/packages/features/app_shell"

if [ -d "$APP_SHELL_PATH" ]; then
    print_error "app_shell feature zaten mevcut: $APP_SHELL_PATH"
    echo ""
    print_warning "Eğer yeniden oluşturmak isterseniz, önce mevcut olanı silin:"
    echo "  rm -rf $APP_SHELL_PATH"
    exit 1
fi

print_info "App Shell, bottom navigation için gerekli yapıyı oluşturur."
print_info "Bu feature, tab-based navigation için temel katman sağlar."
echo ""

# Ask for number of tabs
while true; do
    echo -e "${YELLOW}Kaç tab oluşturmak istersiniz? (2-5 arası):${NC}"
    read -p "Tab sayısı: " tab_count

    if [[ "$tab_count" =~ ^[2-5]$ ]]; then
        break
    else
        print_error "Lütfen 2-5 arasında bir sayı girin!"
    fi
done

print_success "Tab sayısı: $tab_count"
echo ""

# Ask for tab names
declare -a tab_names
declare -a tab_labels
declare -a tab_icons

echo -e "${YELLOW}Her tab için isim ve bilgileri girin:${NC}"
echo ""

for ((i=1; i<=tab_count; i++)); do
    echo -e "${CYAN}Tab $i:${NC}"

    while true; do
        read -p "  İsim (örn: home, profile): " tab_name

        if validate_package_name "$tab_name"; then
            tab_names+=("$tab_name")
            break
        else
            print_error "Geçersiz isim! Küçük harf, rakam ve alt çizgi içerebilir."
        fi
    done

    read -p "  Label (örn: Ana Sayfa): " tab_label
    tab_labels+=("$tab_label")

    read -p "  Icon (örn: home, person, settings): " tab_icon
    tab_icons+=("$tab_icon")

    echo ""
done

# Show summary
echo -e "${YELLOW}Oluşturulacak Tab'ler:${NC}"
echo "─────────────────────────────────────────"
for ((i=0; i<tab_count; i++)); do
    echo "  $((i+1)). ${tab_names[$i]} - ${tab_labels[$i]} (${tab_icons[$i]})"
done
echo ""

if ! confirm_action "App Shell'i oluşturmak istediğinize emin misiniz?"; then
    print_warning "İşlem iptal edildi."
    exit 0
fi

print_header "App Shell Feature Oluşturuluyor..."

# Create directory structure
print_step "Klasör yapısı oluşturuluyor..."
mkdir -p "$APP_SHELL_PATH/lib/src/core/di"
mkdir -p "$APP_SHELL_PATH/lib/src/core/router"
mkdir -p "$APP_SHELL_PATH/lib/src/presentation/bloc"
mkdir -p "$APP_SHELL_PATH/lib/src/presentation/pages"
mkdir -p "$APP_SHELL_PATH/test"

# Create pubspec.yaml
print_step "pubspec.yaml oluşturuluyor..."
cat > "$APP_SHELL_PATH/pubspec.yaml" << 'EOF'
name: app_shell
description: "App Shell feature with bottom navigation"
version: 0.0.1
publish_to: none
resolution: workspace

environment:
  sdk: ^3.9.2
  flutter: ">=1.17.0"

dependencies:
  flutter:
    sdk: flutter

  # Internal packages
  core:
    path: ../../shared/core
  event_bus:
    path: ../../infrastructure/event_bus

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: any
  freezed: ^3.2.3
  json_serializable: ^6.11.1
  injectable_generator: ^2.8.1
  auto_route_generator: ^10.2.5
EOF

print_success "pubspec.yaml oluşturuldu"

# Create barrel export file
print_step "Barrel export dosyası oluşturuluyor..."
cat > "$APP_SHELL_PATH/lib/app_shell.dart" << 'EOF'
library app_shell;

// Core exports
export 'src/core/di/injection.dart';
export 'src/core/router/app_shell_router.dart';
export 'src/core/router/app_shell_routes.dart';
export 'src/core/router/tab_routers.dart';

// Presentation exports
export 'src/presentation/bloc/app_bloc.dart';
export 'src/presentation/pages/app_page.dart';
EOF

print_success "app_shell.dart oluşturuldu"

# Create DI file
print_step "Dependency Injection dosyası oluşturuluyor..."
cat > "$APP_SHELL_PATH/lib/src/core/di/injection.dart" << 'EOF'
import 'package:core/core.dart';

/// Initialize dependency injection for app_shell package
@InjectableInit.microPackage()
initMicroPackage() {}
EOF

print_success "injection.dart oluşturuldu"

# Create app_shell_routes.dart
print_step "Routes dosyası oluşturuluyor..."
cat > "$APP_SHELL_PATH/lib/src/core/router/app_shell_routes.dart" << 'EOF'
/// Route path constants for app_shell feature
final class AppShellRoutes {
  static AppShellRoutes? _instance;

  /// Singleton factory constructor
  factory AppShellRoutes() => _instance ??= AppShellRoutes._();

  /// Private constructor
  AppShellRoutes._();

  /// Main app shell route
  String get main => '/app';
}
EOF

print_success "app_shell_routes.dart oluşturuldu"

# Create app_shell_router.dart (empty, managed by root)
print_step "Router dosyası oluşturuluyor..."
cat > "$APP_SHELL_PATH/lib/src/core/router/app_shell_router.dart" << 'EOF'
import 'package:core/core.dart';

/// Router configuration for app_shell feature
/// Routes are orchestrated by the root app
@AutoRouterConfig(replaceInRouteName: 'Page|View,Route')
@lazySingleton
class AppShellRouter extends RootStackRouter {
  @override
  final List<AutoRoute> routes = [];
}
EOF

print_success "app_shell_router.dart oluşturuldu"

# Create tab_routers.dart
print_step "Tab routers dosyası oluşturuluyor..."
cat > "$APP_SHELL_PATH/lib/src/core/router/tab_routers.dart" << 'EOF'
import 'package:core/core.dart';

EOF

for tab_name in "${tab_names[@]}"; do
    TAB_PASCAL=$(to_pascal_case "$tab_name")
    cat >> "$APP_SHELL_PATH/lib/src/core/router/tab_routers.dart" << EOF
@RoutePage(name: '${TAB_PASCAL}TabRoute')
class ${TAB_PASCAL}TabPage extends AutoRouter {
  const ${TAB_PASCAL}TabPage({super.key});
}

EOF
done

print_success "tab_routers.dart oluşturuldu"

# Create BLoC files
print_step "BLoC dosyaları oluşturuluyor..."

# app_bloc.dart
cat > "$APP_SHELL_PATH/lib/src/presentation/bloc/app_bloc.dart" << 'EOF'
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
EOF

# app_event.dart
cat > "$APP_SHELL_PATH/lib/src/presentation/bloc/app_event.dart" << 'EOF'
part of 'app_bloc.dart';

/// App Shell events
@freezed
abstract class AppEvent with _$AppEvent {
  /// Change bottom navigation tab index
  const factory AppEvent.changeTabIndex({required int index}) =
      AppEventChangeTabIndex;
}
EOF

# app_state.dart
cat > "$APP_SHELL_PATH/lib/src/presentation/bloc/app_state.dart" << 'EOF'
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
EOF

print_success "BLoC dosyaları oluşturuldu"

# Create app_page.dart
print_step "Ana sayfa oluşturuluyor..."

cat > "$APP_SHELL_PATH/lib/src/presentation/pages/app_page.dart" << 'PAGEEOF'
import 'package:app_shell/src/core/router/app_shell_router.gr.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../bloc/app_bloc.dart';

@RoutePage()
class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        // Extract current tab index from state
        final currentIndex = state.map(
          initial: (state) => state.currentTabIndex,
          tabChanged: (state) => state.currentTabIndex,
        );

        return AutoTabsRouter(
          routes: [
PAGEEOF

# Add tab routes
for tab_name in "${tab_names[@]}"; do
    TAB_PASCAL=$(to_pascal_case "$tab_name")
    echo "            ${TAB_PASCAL}TabRoute()," >> "$APP_SHELL_PATH/lib/src/presentation/pages/app_page.dart"
done

cat >> "$APP_SHELL_PATH/lib/src/presentation/pages/app_page.dart" << 'PAGEEOF2'
          ],
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);

            // Sync the tab router with bloc state
            if (tabsRouter.activeIndex != currentIndex) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                tabsRouter.setActiveIndex(currentIndex);
              });
            }

            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  // Trigger bloc event when user taps
                  context.read<AppBloc>().add(
                    AppEvent.changeTabIndex(index: index),
                  );
                },
                items: const [
PAGEEOF2

# Add bottom nav items
for ((i=0; i<tab_count; i++)); do
    cat >> "$APP_SHELL_PATH/lib/src/presentation/pages/app_page.dart" << EOF
                  BottomNavigationBarItem(
                    icon: Icon(Icons.${tab_icons[$i]}),
                    label: '${tab_labels[$i]}',
                  ),
EOF
done

cat >> "$APP_SHELL_PATH/lib/src/presentation/pages/app_page.dart" << 'PAGEEOF3'
                ],
              ),
            );
          },
        );
      },
    );
  }
}
PAGEEOF3

print_success "app_page.dart oluşturuldu"

# Create basic files
print_step "Diğer dosyalar oluşturuluyor..."

# README.md
cat > "$APP_SHELL_PATH/README.md" << EOF
# App Shell

Bottom navigation ile app shell feature'ı.

## Özellikler

- **Tab Sayısı**: $tab_count
- **Tab'ler**: ${tab_names[*]}
- BLoC pattern ile state management
- AutoRoute ile nested routing
- EventBus entegrasyonu

## Kullanım

Bu feature, root app tarafından orchestrate edilir.

### Code Generation

\`\`\`bash
cd packages/features/app_shell
dart run build_runner build --delete-conflicting-outputs
\`\`\`

## Tab'ler

EOF

for ((i=0; i<tab_count; i++)); do
    echo "- **${tab_names[$i]}**: ${tab_labels[$i]} (${tab_icons[$i]})" >> "$APP_SHELL_PATH/README.md"
done

# LICENSE
cp "$PROJECT_ROOT/LICENSE" "$APP_SHELL_PATH/LICENSE" 2>/dev/null || cat > "$APP_SHELL_PATH/LICENSE" << 'EOF'
MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction.
EOF

# CHANGELOG.md
cat > "$APP_SHELL_PATH/CHANGELOG.md" << EOF
# Changelog

## [0.0.1] - $(date +%Y-%m-%d)

### Added
- Initial app_shell feature
- Bottom navigation with $tab_count tabs
- BLoC state management
- EventBus integration
EOF

# .gitignore
cat > "$APP_SHELL_PATH/.gitignore" << 'EOF'
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
EOF

# analysis_options.yaml
cat > "$APP_SHELL_PATH/analysis_options.yaml" << 'EOF'
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_single_quotes: true
    prefer_relative_imports: true
    always_use_package_imports: false

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.gr.dart"
  errors:
    invalid_annotation_target: ignore
EOF

print_success "Tüm dosyalar oluşturuldu"

print_header "App Shell Başarıyla Oluşturuldu!"

echo -e "${GREEN}✓ Feature: app_shell${NC}"
echo -e "${GREEN}✓ Dizin: $APP_SHELL_PATH${NC}"
echo -e "${GREEN}✓ Tab Sayısı: $tab_count${NC}\n"

# Next steps
print_header "Sonraki Adımlar"

echo -e "${YELLOW}1. Code Generation Çalıştırın:${NC}"
echo -e "   ${BLUE}cd $APP_SHELL_PATH${NC}"
echo -e "   ${BLUE}dart run build_runner build --delete-conflicting-outputs${NC}\n"

echo -e "${YELLOW}2. Root App'e app_shell'i Ekleyin:${NC}\n"

echo -e "${CYAN}   a) pubspec.yaml:${NC}"
echo -e "      ${BLUE}app/root/pubspec.yaml${NC} dosyasına ekleyin:"
cat << 'PUBSPEC'
      dependencies:
        app_shell:
          path: ../../packages/features/app_shell
PUBSPEC
echo ""

echo -e "${CYAN}   b) Dependency Injection:${NC}"
echo -e "      ${BLUE}app/root/lib/core/di/injection_container.dart${NC} dosyasına ekleyin:"
cat << 'DI'
      @InjectableInit(
        externalPackageModulesAfter: [
          ExternalModule(AppShellPackageModule),  // ← Ekleyin
          // ... diğer modüller
        ],
      )
DI
echo ""

echo -e "${CYAN}   c) Routing:${NC}"
echo -e "      ${BLUE}app/root/lib/core/route/app_router.dart${NC} dosyasına ekleyin:"
cat << 'ROUTING'
      import 'package:app_shell/app_shell.dart';

      @AutoRouterConfig.autoDiscover(...)
      class AppRouter extends RootStackRouter {
        @override
        List<AutoRoute> get routes => [
          // Login/Splash route'ları...

          // App Shell route (authenticated)
          AutoRoute(
            page: AppRoute.page,
            path: '/app',
            children: [
ROUTING

for tab_name in "${tab_names[@]}"; do
    TAB_PASCAL=$(to_pascal_case "$tab_name")
    echo -e "              AutoRoute(page: ${TAB_PASCAL}TabRoute.page, path: '${tab_name}'),"
done

cat << 'ROUTING2'
            ],
          ),

          // Redirect / to /app
          RedirectRoute(path: '/', redirectTo: '/app'),
        ];
      }
ROUTING2
echo ""

echo -e "${YELLOW}3. Her Tab İçin Feature Oluşturun:${NC}\n"

for tab_name in "${tab_names[@]}"; do
    echo -e "   ${BLUE}./dev${NC} → ${GREEN}1${NC} (Yeni Paket) → ${GREEN}1${NC} (Feature) → ${CYAN}${tab_name}${NC}"
done
echo ""

echo -e "${YELLOW}4. Tab Router'ları Güncelleyin:${NC}"
echo -e "   Her feature'ın router'ında, app_shell'in tab route'una child route ekleyin.\n"

echo -e "   Örnek (${tab_names[0]} feature için):"
TAB_PASCAL_FIRST=$(to_pascal_case "${tab_names[0]}")
cat << EOF
   ${BLUE}packages/features/${tab_names[0]}/lib/src/core/route/${tab_names[0]}_router.dart${NC}:

   @AutoRouterConfig(...)
   class ${TAB_PASCAL_FIRST}Router extends RootStackRouter {
     @override
     List<AutoRoute> routes = [
       AutoRoute(page: ${TAB_PASCAL_FIRST}Route.page, initial: true),
       // ... other routes
     ];
   }
EOF
echo ""

echo -e "${YELLOW}5. Melos Bootstrap ve Code Generation:${NC}"
echo -e "   ${BLUE}melos bootstrap${NC}"
echo -e "   ${BLUE}melos run codegen${NC}\n"

echo -e "${YELLOW}6. Root App'i Çalıştırın:${NC}"
echo -e "   ${BLUE}cd app/root${NC}"
echo -e "   ${BLUE}flutter run${NC}\n"

print_header "EventBus Kullanımı (Opsiyonel)"

echo -e "${CYAN}Feature'lardan tab değiştirmek için:${NC}\n"
cat << 'EVENTBUS'
// Herhangi bir feature'dan tab değiştir
EventBus.I.publish(ChangeBottomNavIndexEvent(newIndex: 1));
EVENTBUS
echo ""

echo -e "${GREEN}App Shell oluşturma tamamlandı! 🎉${NC}\n"
