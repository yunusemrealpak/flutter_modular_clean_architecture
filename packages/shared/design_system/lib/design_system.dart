/// Design System Package
///
/// Provides a comprehensive design system with consistent:
/// - Colors (primary, secondary, semantic, neutral)
/// - Typography (display, headline, title, body, label styles)
/// - Spacing (padding, margin, gap, radius, icon sizes)
/// - Theme (light/dark theme configurations)
/// - Widgets (buttons, text fields, cards)
library;

// Components (with external dependencies/callbacks)
export 'src/components/theme_switch/app_theme_switch.dart';
export 'src/components/theme_switch/app_theme_switch_tile.dart';
export 'src/components/theme_switch/app_theme_switch_variant.dart';
// Foundation
export 'src/foundation/app_colors.dart';
export 'src/foundation/app_responsive.dart';
export 'src/foundation/app_spacing.dart';
export 'src/foundation/app_spacing_responsive.dart';
export 'src/foundation/app_typography.dart';
export 'src/foundation/app_typography_responsive.dart';
// Theme
export 'src/theme/app_theme.dart';
// Utils
export 'src/utils/extensions.dart';
// Widgets
export 'src/widgets/app_button.dart';
export 'src/widgets/app_card.dart';
export 'src/widgets/app_text_field.dart';
