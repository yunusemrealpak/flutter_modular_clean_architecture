import 'package:flutter/material.dart';
import 'package:design_system/src/foundation/app_spacing.dart';

/// Wrapper for app cards with consistent styling
///
/// Provides a standardized card widget with optional header and footer.
/// Uses theme configuration for styling.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.paddingMD),
      child: child,
    );

    return Card(
      margin: margin,
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
              child: content,
            )
          : content,
    );
  }
}

/// Card with header section
class AppCardWithHeader extends StatelessWidget {
  const AppCardWithHeader({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.padding,
    this.margin,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      padding: EdgeInsets.zero,
      margin: margin,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMD,
                  vertical: AppSpacing.paddingSM,
                ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          // Divider
          const Divider(height: 1),
          // Body
          Padding(
            padding: padding ?? const EdgeInsets.all(AppSpacing.paddingMD),
            child: child,
          ),
        ],
      ),
    );
  }
}
