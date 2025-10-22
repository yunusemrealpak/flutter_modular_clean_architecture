import 'package:flutter/material.dart';
import 'package:design_system/src/foundation/app_spacing.dart';

/// Wrapper for app buttons with consistent styling
///
/// Provides three variants: primary (elevated), secondary (outlined), and text.
/// Supports customization with colors, size, elevation, and more.
///
/// Example:
/// ```dart
/// AppButton(
///   label: 'Submit',
///   onPressed: () {},
///   variant: AppButtonVariant.primary,
///   backgroundColor: Colors.green,
///   icon: Icons.check,
/// )
/// ```
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.elevation,
    this.minimumSize,
    this.padding,
  });

  final VoidCallback? onPressed;
  final String label;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  /// Custom background color (overrides theme)
  final Color? backgroundColor;

  /// Custom text/icon color (overrides theme)
  final Color? foregroundColor;

  /// Custom border color (for outlined variant)
  final Color? borderColor;

  /// Custom elevation (for primary variant)
  final double? elevation;

  /// Custom minimum size (overrides theme)
  final Size? minimumSize;

  /// Custom padding (overrides theme)
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final Widget child = isLoading
        ? SizedBox(
            height: AppSpacing.iconSM,
            width: AppSpacing.iconSM,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: foregroundColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSpacing.iconSM),
                const SizedBox(width: AppSpacing.gapXS),
              ],
              Text(label),
            ],
          );

    final ButtonStyle? customStyle = _buildCustomStyle();

    final Widget button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: customStyle,
          child: child,
        ),
      AppButtonVariant.secondary => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: customStyle,
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: customStyle,
          child: child,
        ),
    };

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }

  ButtonStyle? _buildCustomStyle() {
    // If no customization, return null to use theme defaults
    if (backgroundColor == null &&
        foregroundColor == null &&
        borderColor == null &&
        elevation == null &&
        minimumSize == null &&
        padding == null) {
      return null;
    }

    return ButtonStyle(
      backgroundColor: backgroundColor != null
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return backgroundColor!.withOpacity(0.38);
              }
              return backgroundColor;
            })
          : null,
      foregroundColor: foregroundColor != null
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return foregroundColor!.withOpacity(0.38);
              }
              return foregroundColor;
            })
          : null,
      side: borderColor != null
          ? WidgetStateProperty.all(
              BorderSide(color: borderColor!, width: 1.5),
            )
          : null,
      elevation: elevation != null
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return 0;
              }
              if (states.contains(WidgetState.pressed)) {
                return elevation! + 2;
              }
              return elevation;
            })
          : null,
      minimumSize:
          minimumSize != null ? WidgetStateProperty.all(minimumSize) : null,
      padding: padding != null ? WidgetStateProperty.all(padding) : null,
    );
  }
}

/// Button variant enum
enum AppButtonVariant {
  primary,
  secondary,
  text,
}
