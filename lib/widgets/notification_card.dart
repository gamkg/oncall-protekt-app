import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationCard({super.key, required this.notification});

  Color _typeColor(String type) {
    switch (type) {
      case 'urgent':
        return Colors.red;
      case 'warning':
        return Colors.amber;
      case 'success':
        return Colors.green;
      default:
        return const Color(0xFF00E5CC);
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'urgent':
        return Icons.warning_amber_rounded;
      case 'warning':
        return Icons.shield_outlined;
      case 'success':
        return Icons.check_circle_outline;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.read<ThemeProvider>().mode == AppThemeMode.sentinelDark;
    final color = _typeColor(notification['type']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
        border: Border(
          left: BorderSide(color: color, width: 3),
          top: BorderSide(color: extras?.cardBorderColor ?? Colors.transparent),
          right: BorderSide(color: extras?.cardBorderColor ?? Colors.transparent),
          bottom: BorderSide(color: extras?.cardBorderColor ?? Colors.transparent),
        ),
        boxShadow: isSentinel
            ? [BoxShadow(color: extras?.glowColor ?? Colors.transparent, blurRadius: 6)]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_typeIcon(notification['type']), color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    notification['title'],
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: isSentinel ? 'FiraCode' : null,
                    ),
                  ),
                ),
                Text(
                  notification['time'],
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              notification['body'],
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
            ),
            if (notification['hasActions'] == true) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: color,
                        side: BorderSide(color: color),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(isSentinel ? 'DISPATCH UNIT' : 'Dispatch Unit'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.textTheme.bodyMedium?.color,
                        side: BorderSide(
                            color: extras?.cardBorderColor ?? Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(isSentinel ? 'DISMISS' : 'Dismiss'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
