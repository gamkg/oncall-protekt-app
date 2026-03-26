import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';

class StatBadge extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const StatBadge({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.read<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
        border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
        boxShadow: isSentinel
            ? [BoxShadow(color: extras?.glowColor ?? Colors.transparent, blurRadius: 8)]
            : null,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(fontSize: 22),
              ),
              if (icon != null) ...[
                const SizedBox(width: 4),
                Icon(icon, color: theme.colorScheme.primary, size: 16),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
