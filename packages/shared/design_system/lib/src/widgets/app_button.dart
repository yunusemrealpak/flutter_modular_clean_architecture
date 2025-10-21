import 'package:flutter/material.dart';
import 'package:design_system/src/foundation/app_spacing.dart';

/// Wrapper for app buttons with consistent styling
///
/// Provides three variants: primary (elevated), secondary (outlined), and text.
/// Uses theme configuration for styling.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String label;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final Widget child = isLoading
        ? const SizedBox(
            height: AppSpacing.iconSM,
            width: AppSpacing.iconSM,
            child: CircularProgressIndicator(strokeWidth: 2),
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

    final Widget button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        ),
      AppButtonVariant.secondary => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
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
}

/// Button variant enum
enum AppButtonVariant {
  primary,
  secondary,
  text,
}
