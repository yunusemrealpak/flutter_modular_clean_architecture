# Design System

Flutter için modüler, ölçeklenebilir design system paketi.

## Özellikler

- **Foundation**: Renk paleti, tipografi, spacing sistemi
- **Theme**: Light/Dark tema konfigürasyonu
- **Widgets**: Yeniden kullanılabilir, tutarlı UI bileşenleri

## Kullanım

### Statik Değerler (Tüm ekranlarda aynı)

```dart
import 'package:design_system/design_system.dart';

// Renkleri kullanma
Container(color: AppColors.primary)

// Typography kullanma
Text('Hello', style: AppTypography.headlineLarge)

// Spacing kullanma
SizedBox(height: AppSpacing.md)

// Widget kullanma
AppButton(
  label: 'Click me',
  onPressed: () {},
)
```

### Responsive Değerler (Ekran boyutuna göre scale olur)

```dart
import 'package:design_system/design_system.dart';

// Responsive typography (önerilen)
Text('Hello', style: AppTypographyResponsive.headlineLarge)

// Responsive spacing (önerilen)
SizedBox(height: AppSpacingResponsive.md)

// Manuel responsive değerler
Text(
  'Custom',
  style: TextStyle(fontSize: context.sp(18)),
)
Padding(padding: EdgeInsets.all(context.w(20)))
```

**Not:** Emülatörde normal ama gerçek cihazda font size'lar büyük görünüyorsa, `FONT_SIZE_GUIDE.md` dosyasına bak.

## Tema Kurulumu

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  // ...
)
```

## Bileşenler

### Foundation
- `AppColors`: Tüm renk token'ları
- `AppTypography` / `AppTypographyResponsive`: Text stil hiyerarşisi (statik/responsive)
- `AppSpacing` / `AppSpacingResponsive`: Spacing değerleri (statik/responsive)
- `AppResponsive`: Ekran boyutu ve responsive helper'lar

### Widgets
- `AppButton`: Primary, secondary, text button varyantları
- `AppTextField`: Standart text input
- `AppCard`: Card ve header'lı card varyantları

### Components
- `AppThemeSwitch`: Tema değiştirme component'i (toggle, icon button, segmented varyantları)
- `AppThemeSwitchTile`: Label'lı tema switcher (ListTile formatında)

## Component Kullanımı

Component'ler state management gerektiren UI elemanlarıdır. Callback ile kullanılır:

```dart
// Profil sayfasında
AppThemeSwitch(
  currentTheme: themeManager.currentTheme,  // Dışardan state
  onThemeChanged: (mode) {
    themeManager.setThemeMode(mode);  // Dışardan logic
  },
  variant: AppThemeSwitchVariant.toggle,  // toggle, iconButton, segmented
)

// ListTile versiyonu
AppThemeSwitchTile(
  currentTheme: themeManager.currentTheme,
  onThemeChanged: (mode) => themeManager.setThemeMode(mode),
  title: 'Karanlık Mod',
  subtitle: 'Göz yorgunluğunu azaltır',
)
```

## Font Size Sorunları

Eğer gerçek cihazlarda font size'lar çok büyük görünüyorsa, `FONT_SIZE_GUIDE.md` dosyasına bakın.

## Geliştirme

Detaylı rehber için `DESIGN_SYSTEM_GUIDE.md` dosyasına bakın.
