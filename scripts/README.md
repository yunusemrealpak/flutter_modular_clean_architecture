# Scripts Directory Documentation

Bu klasör, Flutter Modular Clean Architecture projesi için tüm geliştirme script'lerini içerir.

## 📁 Klasör Yapısı

```
scripts/
├── cli.sh                          # Ana menü ve orchestrator
├── common/                         # Ortak fonksiyonlar
│   └── functions.sh                #   - Print utilities
│                                   #   - String manipulations
│                                   #   - Path helpers
├── generators/                     # Kod üretici script'ler
│   ├── create_package.sh           #   - Yeni paket oluşturma
│   ├── create_bloc.sh              #   - BLoC ekleme
│   └── create_app_shell.sh         #   - App Shell (Bottom Navigation)
└── utils/                          # Yardımcı araçlar
    └── list_packages.sh            #   - Paket listesi
```

## 🎯 Script Kategorileri

### 📜 cli.sh - Ana Orchestrator

**Sorumluluk:** Interaktif menü ve diğer script'leri koordine etme

**Kullanım:**
```bash
# Root'tan çağrılır
./dev

# Veya doğrudan
bash scripts/cli.sh
```

**Özellikler:**
- Interaktif menü sistemi
- Script routing
- Error handling
- User feedback

**Menü Seçenekleri:**
1. Yeni Paket Oluştur → `generators/create_package.sh`
2. BLoC Ekle → `generators/create_bloc.sh`
3. App Shell Oluştur → `generators/create_app_shell.sh`
4. Paketleri Listele → `utils/list_packages.sh`
5. Yardım
0. Çıkış

---

### 🧰 common/functions.sh - Ortak Fonksiyonlar

**Sorumluluk:** Tüm script'ler tarafından kullanılan yardımcı fonksiyonlar

**Fonksiyon Kategorileri:**

#### Print Fonksiyonları
```bash
print_success "İşlem başarılı"      # ✓ Yeşil
print_error "Hata oluştu"           # ✗ Kırmızı
print_warning "Uyarı mesajı"        # ⚠ Sarı
print_info "Bilgi"                  # ℹ Mavi
print_step "İşlem adımı"            # [*] Cyan
print_header "Başlık"               # ═══ Çerçeveli mavi
```

#### String İşlemleri
```bash
to_pascal_case "vehicle_acceptance"  # → VehicleAcceptance
to_pascal_case "my_feature_name"     # → MyFeatureName
```

#### Validasyon
```bash
validate_package_name "my_package"   # → 0 (valid)
validate_package_name "MyPackage"    # → 1 (invalid)

package_exists "/path/to/package"    # → 0 (exists) / 1 (not exists)
```

#### Path Helpers
```bash
get_project_root                     # → /project/root/path
get_package_type "/path/to/pkg"      # → feature|shared|infrastructure
```

#### User Interaction
```bash
confirm_action "Devam edilsin mi?"   # → 0 (yes) / 1 (no)
```

**Kullanım:**
```bash
# Script başında source et
source "$SCRIPT_DIR/../common/functions.sh"

# Fonksiyonları kullan
print_header "İşlem Başlıyor"
PASCAL=$(to_pascal_case "my_feature")
if confirm_action "Devam edilsin mi?"; then
    print_success "Onaylandı"
fi
```

---

### 🏗️ generators/create_package.sh - Paket Oluşturucu

**Sorumluluk:** Yeni Flutter paketi (Feature/Shared/Infrastructure) oluşturma

**Satır Sayısı:** ~1729 satır

**Akış:**
1. Paket türü seçimi (Feature/Shared/Infrastructure)
2. Paket adı girişi
3. Validasyon
4. PascalCase dönüşümü
5. Klasör yapısı oluşturma
6. Dosya template'leri oluşturma
7. Onay ve özet

**Feature Paketi İçeriği:**
```
packages/features/{name}/
├── pubspec.yaml                    # Dependencies (core, network, etc.)
├── lib/
│   ├── {name}.dart                # Barrel exports
│   └── src/
│       ├── core/
│       │   ├── di/
│       │   │   └── injection.dart             # Injectable setup
│       │   ├── route/
│       │   │   ├── {name}_router.dart         # AutoRoute config
│       │   │   └── {name}_routes.dart         # Route constants
│       │   └── errors/
│       │       └── failures.dart              # Failure hierarchy
│       └── feature/
│           ├── data/
│           │   ├── datasources/
│           │   │   ├── example_local_datasource.dart
│           │   │   └── example_remote_datasource.dart
│           │   ├── models/
│           │   │   └── example_model.dart     # Freezed model
│           │   └── repositories/
│           │       └── example_repository_impl.dart
│           ├── domain/
│           │   ├── entities/
│           │   │   └── example_entity.dart
│           │   ├── repositories/
│           │   │   └── example_repository.dart
│           │   └── usecases/
│           │       └── get_example_data_usecase.dart
│           └── presentation/
│               ├── bloc/
│               │   ├── {name}_bloc.dart
│               │   ├── {name}_event.dart
│               │   └── {name}_state.dart
│               └── pages/
│                   └── {name}_page.dart
└── test/
    └── src/feature/presentation/bloc/
        └── {name}_bloc_test.dart
```

**Dahil Edilen Özellikler:**
- ✅ Clean Architecture katmanları
- ✅ Freezed models ve BLoC
- ✅ Injectable DI
- ✅ AutoRoute setup
- ✅ Network ve Storage entegrasyonu
- ✅ Örnek UseCase, Entity, Repository
- ✅ Örnek BLoC ve Page
- ✅ Unit test template

---

### 🎨 generators/create_bloc.sh - BLoC Oluşturucu

**Sorumluluk:** Mevcut pakete yeni BLoC ekleme

**Satır Sayısı:** ~259 satır

**Akış:**
1. Mevcut paketleri listele (feature/infra/shared - hepsi)
2. Kullanıcı paket seçer (numara ile)
3. BLoC adı girişi
4. Validasyon
5. PascalCase dönüşümü
6. 3 dosya oluşturma
7. Kullanım rehberi göster

**Oluşturulan Dosyalar:**
```dart
// {bloc_name}_bloc.dart
@lazySingleton
class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(const ExampleState.initial()) {
    on<ExampleEventLoad>(_onLoad);
    on<ExampleEventRefresh>(_onRefresh);
    on<ExampleEventDelete>(_onDelete);
  }
}

// {bloc_name}_event.dart
@freezed
class ExampleEvent with _$ExampleEvent {
  const factory ExampleEvent.load({String? id}) = ExampleEventLoad;
  const factory ExampleEvent.refresh() = ExampleEventRefresh;
  const factory ExampleEvent.delete({required String id}) = ExampleEventDelete;
}

// {bloc_name}_state.dart
@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = ExampleStateInitial;
  const factory ExampleState.loading() = ExampleStateLoading;
  const factory ExampleState.loaded(dynamic data) = ExampleStateLoaded;
  const factory ExampleState.error(String message) = ExampleStateError;
  const factory ExampleState.deleteSuccess() = ExampleStateDeleteSuccess;
}
```

**Dahil Edilen Özellikler:**
- ✅ Freezed annotations
- ✅ Injectable DI
- ✅ 3 örnek event (Load, Refresh, Delete)
- ✅ 5 örnek state
- ✅ TODO yorumları
- ✅ Örnek implementasyon
- ✅ Kullanım örnekleri (BlocConsumer)

---

### 🏗️ generators/create_app_shell.sh - App Shell Oluşturucu

**Sorumluluk:** Bottom navigation ile app shell feature'ı oluşturma

**Satır Sayısı:** ~650+ satır

**Akış:**
1. Mevcut paketleri listele (feature/infra/shared - hepsi)
2. Kullanıcı paket seçer (numara ile)
3. BLoC adı girişi
4. Validasyon
5. PascalCase dönüşümü
6. 3 dosya oluşturma
7. Kullanım rehberi göster

**Oluşturulan Dosyalar:**
```dart
// {bloc_name}_bloc.dart
@lazySingleton
class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(const ExampleState.initial()) {
    on<ExampleEventLoad>(_onLoad);
    on<ExampleEventRefresh>(_onRefresh);
    on<ExampleEventDelete>(_onDelete);
  }
}

// {bloc_name}_event.dart
@freezed
class ExampleEvent with _$ExampleEvent {
  const factory ExampleEvent.load({String? id}) = ExampleEventLoad;
  const factory ExampleEvent.refresh() = ExampleEventRefresh;
  const factory ExampleEvent.delete({required String id}) = ExampleEventDelete;
}

// {bloc_name}_state.dart
@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = ExampleStateInitial;
  const factory ExampleState.loading() = ExampleStateLoading;
  const factory ExampleState.loaded(dynamic data) = ExampleStateLoaded;
  const factory ExampleState.error(String message) = ExampleStateError;
  const factory ExampleState.deleteSuccess() = ExampleStateDeleteSuccess;
}
```

**Dahil Edilen Özellikler:**
- ✅ Freezed annotations
- ✅ Injectable DI
- ✅ 3 örnek event (Load, Refresh, Delete)
- ✅ 5 örnek state
- ✅ TODO yorumları
- ✅ Örnek implementasyon
- ✅ Kullanım örnekleri (BlocConsumer)

---

### 📊 utils/list_packages.sh - Paket Listesi

**Sorumluluk:** Projedeki tüm paketleri listelemek

**Satır Sayısı:** ~116 satır

**Fonksiyonlar:**
```bash
list_all_packages()          # Tüm paketleri array olarak döner
display_packages()           # Formatted tablo çıktısı
get_package_by_number(num)   # Numara ile paket bilgisi
```

**Çıktı Formatı:**
```
No.   Type            Package Name
──────────────────────────────────────────────────
1     [feature]       auth                  (yeşil)
2     [feature]       home                  (yeşil)
3     [infrastructure] network              (mavi)
4     [shared]        config                (sarı)
```

**Kullanım:**
```bash
# Source ederek fonksiyonları kullan
source "$SCRIPT_DIR/../utils/list_packages.sh"

# Paketleri göster
display_packages

# Veya programmatic olarak
packages=($(list_all_packages))
for pkg_info in "${packages[@]}"; do
    IFS='|' read -r num type name path <<< "$pkg_info"
    echo "Package: $name"
done
```

---

## 🔄 Script İletişimi

```
dev (wrapper)
  ├─→ scripts/cli.sh (menü)
       ├─→ generators/create_package.sh
       │    └─→ common/functions.sh
       │
       ├─→ generators/create_bloc.sh
       │    ├─→ common/functions.sh
       │    └─→ utils/list_packages.sh
       │
       └─→ utils/list_packages.sh
            └─→ common/functions.sh
```

## 📝 Yeni Script Ekleme Rehberi

### 1. Kategori Belirle

- **Generator** mı? → `generators/`
- **Utility** mi? → `utils/`
- **Başka kategori?** → Yeni klasör oluştur

### 2. Script Oluştur

```bash
#!/bin/bash

# Script açıklaması

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
source "$SCRIPT_DIR/../common/functions.sh"

# Get project root
PROJECT_ROOT=$(get_project_root)

# Script logic
print_header "Script Başlığı"
# ... kodunuz
```

### 3. Ana Menüye Ekle

`scripts/cli.sh` dosyasına ekleyin:

```bash
# Menüde yeni seçenek
echo -e "${GREEN}5)${NC} Yeni İşlem"

# Fonksiyon ekle
run_new_feature() {
    bash "$SCRIPT_DIR/generators/new_script.sh"
    # ...
}

# Case'e ekle
5)
    run_new_feature
    ;;
```

### 4. Test Et

```bash
# Syntax kontrolü
bash -n scripts/xxx/new_script.sh

# Executable yap
chmod +x scripts/xxx/new_script.sh

# Line ending düzelt (Windows)
sed -i 's/\r$//' scripts/xxx/new_script.sh

# Çalıştır
./dev
```

## 🎨 Best Practices

### ✅ Yapılması Gerekenler

1. **Ortak fonksiyonları kullan** - `common/functions.sh`
2. **Tutarlı print kullan** - `print_success`, `print_error`, vb.
3. **Her önemli işlemde onay al** - `confirm_action`
4. **Path'leri relative kullan** - `$SCRIPT_DIR/../`
5. **Error handling ekle** - `if [ $? -ne 0 ]; then ...`
6. **Kullanıcıya bilgi ver** - `print_step`, `print_info`
7. **Dokümantasyon yaz** - Script başında ve karmaşık kısımlarda
8. **Kodları modüler tut** - Tek sorumluluk prensibi

### ❌ Yapılmaması Gerekenler

1. **Absolute path kullanma** - Taşınabilirlik sorunu
2. **Renksiz çıktı** - Print fonksiyonları kullan
3. **Onaysız kritik işlem** - Kullanıcıya sor
4. **Hata kontrolsüz kod** - Her önemli işlemi kontrol et
5. **İç içe script** - Fonksiyon çağır, script çağırma
6. **Global değişken kirliliği** - Local değişken kullan
7. **Yorumsuz kod** - Açıklama ekle

## 🐛 Debugging

### Verbose Mode

```bash
# Script'i debug modunda çalıştır
bash -x scripts/cli.sh
```

### Path Debug

```bash
# Script directory'i kontrol et
echo "SCRIPT_DIR: $SCRIPT_DIR"
echo "PROJECT_ROOT: $PROJECT_ROOT"
```

### Function Debug

```bash
# Fonksiyon çıktısını kontrol et
result=$(to_pascal_case "test_case")
echo "Result: $result"
```

## 📚 İleri Okuma

- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
- [Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- Ana proje README: `../SCRIPTS_README.md`

---

**Güncellenme:** 2025
**Versiyon:** 2.0 (Modular Structure)
