#!/bin/bash

# Script to create a new BLoC in an existing package

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
source "$SCRIPT_DIR/../common/functions.sh"
source "$SCRIPT_DIR/../utils/list_packages.sh"

# Get project root
PROJECT_ROOT=$(get_project_root)

print_header "BLoC Generator - Add BLoC to Existing Package"

# Display available packages
display_packages

# Ask user to select a package
echo -e "${YELLOW}Bir paket seçin (numara girin):${NC}"
read -p "Paket numarası: " package_number

# Get package info
package_info=$(get_package_by_number "$package_number")

if [ -z "$package_info" ]; then
    print_error "Geçersiz paket numarası!"
    exit 1
fi

# Parse package info
IFS='|' read -r package_type package_name package_path <<< "$package_info"

print_success "Paket seçildi: $package_name ($package_type)"

# Ask for BLoC name
echo -e "\n${YELLOW}BLoC adını girin (örn: user_profile, settings):${NC}"
read -p "BLoC adı: " bloc_name

# Validate BLoC name
if ! validate_package_name "$bloc_name"; then
    print_error "Geçersiz BLoC adı! Küçük harf, rakam ve alt çizgi içerebilir, harf ile başlamalıdır."
    exit 1
fi

# Convert to PascalCase
BLOC_NAME_PASCAL=$(to_pascal_case "$bloc_name")

print_success "BLoC adı: $bloc_name (Class: ${BLOC_NAME_PASCAL}Bloc)"

# Check if package has presentation/bloc directory
BLOC_DIR="$package_path/lib/src/feature/presentation/bloc"

if [ ! -d "$BLOC_DIR" ]; then
    print_warning "presentation/bloc klasörü bulunamadı, oluşturuluyor..."
    mkdir -p "$BLOC_DIR"
fi

# Check if BLoC already exists
BLOC_FILE="$BLOC_DIR/${bloc_name}_bloc.dart"

if [ -f "$BLOC_FILE" ]; then
    print_error "Bu BLoC zaten mevcut: $BLOC_FILE"
    exit 1
fi

# Confirm creation
echo -e "\n${YELLOW}BLoC oluşturma özeti:${NC}"
echo -e "  Paket     : ${BLUE}$package_name${NC}"
echo -e "  BLoC      : ${BLUE}${BLOC_NAME_PASCAL}Bloc${NC}"
echo -e "  Dizin     : ${BLUE}$BLOC_DIR${NC}"
echo ""

if ! confirm_action "BLoC'u oluşturmak istediğinize emin misiniz?"; then
    print_warning "İşlem iptal edildi."
    exit 0
fi

print_header "BLoC Dosyaları Oluşturuluyor..."

# Create main BLoC file
print_step "Ana BLoC dosyası oluşturuluyor..."
cat > "$BLOC_FILE" << EOF
import 'package:core/core.dart';

part '${bloc_name}_event.dart';
part '${bloc_name}_state.dart';
part '${bloc_name}_bloc.freezed.dart';

/// BLoC for $bloc_name
/// Manages state and handles business logic
@lazySingleton
class ${BLOC_NAME_PASCAL}Bloc extends Bloc<${BLOC_NAME_PASCAL}Event, ${BLOC_NAME_PASCAL}State> {
  // TODO: Inject use cases here
  // final GetDataUseCase getDataUseCase;

  ${BLOC_NAME_PASCAL}Bloc({
    // TODO: Add use case parameters
    // required this.getDataUseCase,
  }) : super(const ${BLOC_NAME_PASCAL}State.initial()) {
    // Register event handlers
    on<${BLOC_NAME_PASCAL}EventLoad>(_onLoad);
    on<${BLOC_NAME_PASCAL}EventRefresh>(_onRefresh);
    on<${BLOC_NAME_PASCAL}EventDelete>(_onDelete);
  }

  /// Handle load event
  Future<void> _onLoad(
    ${BLOC_NAME_PASCAL}EventLoad event,
    Emitter<${BLOC_NAME_PASCAL}State> emit,
  ) async {
    emit(const ${BLOC_NAME_PASCAL}State.loading());

    // TODO: Implement load logic
    // Example:
    // final params = GetDataParams(id: event.id);
    // final result = await getDataUseCase(params);
    //
    // result.fold(
    //   (failure) => emit(${BLOC_NAME_PASCAL}State.error(failure.message)),
    //   (data) => emit(${BLOC_NAME_PASCAL}State.loaded(data)),
    // );

    // Temporary success for testing
    await Future.delayed(const Duration(seconds: 1));
    emit(const ${BLOC_NAME_PASCAL}State.loaded('Sample data loaded'));
  }

  /// Handle refresh event
  Future<void> _onRefresh(
    ${BLOC_NAME_PASCAL}EventRefresh event,
    Emitter<${BLOC_NAME_PASCAL}State> emit,
  ) async {
    emit(const ${BLOC_NAME_PASCAL}State.loading());

    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 1));
    emit(const ${BLOC_NAME_PASCAL}State.loaded('Data refreshed'));
  }

  /// Handle delete event
  Future<void> _onDelete(
    ${BLOC_NAME_PASCAL}EventDelete event,
    Emitter<${BLOC_NAME_PASCAL}State> emit,
  ) async {
    emit(const ${BLOC_NAME_PASCAL}State.loading());

    // TODO: Implement delete logic
    // Example:
    // final params = DeleteParams(id: event.id);
    // final result = await deleteUseCase(params);
    //
    // result.fold(
    //   (failure) => emit(${BLOC_NAME_PASCAL}State.error(failure.message)),
    //   (data) => emit(const ${BLOC_NAME_PASCAL}State.deleteSuccess()),
    // );

    await Future.delayed(const Duration(milliseconds: 500));
    emit(const ${BLOC_NAME_PASCAL}State.deleteSuccess());
  }
}
EOF

print_success "${bloc_name}_bloc.dart oluşturuldu"

# Create event file
print_step "Event dosyası oluşturuluyor..."
cat > "$BLOC_DIR/${bloc_name}_event.dart" << EOF
part of '${bloc_name}_bloc.dart';

/// Events for $bloc_name BLoC
@freezed
class ${BLOC_NAME_PASCAL}Event with _\$${BLOC_NAME_PASCAL}Event {
  /// Load data event
  /// Use this to fetch initial data
  const factory ${BLOC_NAME_PASCAL}Event.load({
    String? id,
  }) = ${BLOC_NAME_PASCAL}EventLoad;

  /// Refresh data event
  /// Use this to reload/refresh existing data
  const factory ${BLOC_NAME_PASCAL}Event.refresh() = ${BLOC_NAME_PASCAL}EventRefresh;

  /// Delete data event
  /// Use this to delete an item
  const factory ${BLOC_NAME_PASCAL}Event.delete({
    required String id,
  }) = ${BLOC_NAME_PASCAL}EventDelete;

  /// Add more events here as needed
  /// Examples:
  ///
  /// const factory ${BLOC_NAME_PASCAL}Event.update({
  ///   required String id,
  ///   required String name,
  /// }) = ${BLOC_NAME_PASCAL}EventUpdate;
  ///
  /// const factory ${BLOC_NAME_PASCAL}Event.create({
  ///   required String name,
  /// }) = ${BLOC_NAME_PASCAL}EventCreate;
  ///
  /// const factory ${BLOC_NAME_PASCAL}Event.search({
  ///   required String query,
  /// }) = ${BLOC_NAME_PASCAL}EventSearch;
}
EOF

print_success "${bloc_name}_event.dart oluşturuldu"

# Create state file
print_step "State dosyası oluşturuluyor..."
cat > "$BLOC_DIR/${bloc_name}_state.dart" << EOF
part of '${bloc_name}_bloc.dart';

/// States for $bloc_name BLoC
@freezed
class ${BLOC_NAME_PASCAL}State with _\$${BLOC_NAME_PASCAL}State {
  /// Initial state - no operation has been performed yet
  const factory ${BLOC_NAME_PASCAL}State.initial() = ${BLOC_NAME_PASCAL}StateInitial;

  /// Loading state - an operation is in progress
  const factory ${BLOC_NAME_PASCAL}State.loading() = ${BLOC_NAME_PASCAL}StateLoading;

  /// Loaded state - data has been successfully loaded
  /// [data] can be any type (String, Entity, List, etc.)
  const factory ${BLOC_NAME_PASCAL}State.loaded(dynamic data) = ${BLOC_NAME_PASCAL}StateLoaded;

  /// Error state - an error occurred during an operation
  const factory ${BLOC_NAME_PASCAL}State.error(String message) = ${BLOC_NAME_PASCAL}StateError;

  /// Delete success state - item successfully deleted
  const factory ${BLOC_NAME_PASCAL}State.deleteSuccess() = ${BLOC_NAME_PASCAL}StateDeleteSuccess;

  /// Add more states here as needed
  /// Examples:
  ///
  /// const factory ${BLOC_NAME_PASCAL}State.updateSuccess() = ${BLOC_NAME_PASCAL}StateUpdateSuccess;
  ///
  /// const factory ${BLOC_NAME_PASCAL}State.createSuccess(dynamic data) = ${BLOC_NAME_PASCAL}StateCreateSuccess;
  ///
  /// const factory ${BLOC_NAME_PASCAL}State.empty() = ${BLOC_NAME_PASCAL}StateEmpty;
  ///
  /// const factory ${BLOC_NAME_PASCAL}State.searching() = ${BLOC_NAME_PASCAL}StateSearching;
}
EOF

print_success "${bloc_name}_state.dart oluşturuldu"

# Success message
print_header "BLoC Başarıyla Oluşturuldu!"

echo -e "${GREEN}✓ BLoC: ${BLOC_NAME_PASCAL}Bloc${NC}"
echo -e "${GREEN}✓ Dosya: $BLOC_FILE${NC}\n"

# Next steps
echo -e "${YELLOW}Sonraki Adımlar:${NC}\n"

echo -e "${BLUE}1. Code generation çalıştırın:${NC}"
echo -e "   cd $package_path"
echo -e "   dart run build_runner build --delete-conflicting-outputs\n"

echo -e "${BLUE}2. Use case'leri implement edin:${NC}"
echo -e "   - BLoC içindeki TODO yorumlarını inceleyin"
echo -e "   - Gerekli use case'leri inject edin"
echo -e "   - Event handler'larda use case'leri kullanın\n"

echo -e "${BLUE}3. BLoC'u DI sistemine ekleyin (otomatik):${NC}"
echo -e "   - @lazySingleton annotation otomatik register eder"
echo -e "   - injectable_generator ile code generation yapın\n"

echo -e "${BLUE}4. UI'da kullanın:${NC}"
echo -e "   - BlocProvider ile provide edin"
echo -e "   - BlocBuilder/BlocConsumer ile dinleyin"
echo -e "   - Event'leri dispatch edin\n"

echo -e "${YELLOW}Örnek Kullanım:${NC}"
cat << 'EXAMPLE'
// UI'da BLoC kullanımı:
BlocConsumer<${BLOC_NAME_PASCAL}Bloc, ${BLOC_NAME_PASCAL}State>(
  listener: (context, state) {
    state.maybeWhen(
      error: (message) => showSnackBar(message),
      deleteSuccess: () => Navigator.pop(context),
      orElse: () {},
    );
  },
  builder: (context, state) {
    return state.when(
      initial: () => Text('Ready'),
      loading: () => CircularProgressIndicator(),
      loaded: (data) => Text('Data: $data'),
      error: (message) => Text('Error: $message'),
      deleteSuccess: () => Text('Deleted!'),
    );
  },
)

// Event dispatch:
context.read<${BLOC_NAME_PASCAL}Bloc>().add(
  const ${BLOC_NAME_PASCAL}Event.load(id: '123'),
);
EXAMPLE

echo -e "\n${GREEN}BLoC oluşturma tamamlandı! 🎉${NC}\n"
