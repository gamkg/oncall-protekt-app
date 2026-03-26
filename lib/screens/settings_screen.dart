import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    final items = [
      {'icon': Icons.lock_outline, 'label': 'Change Password'},
      {'icon': Icons.notifications_outlined, 'label': 'App Notification'},
      {'icon': Icons.delete_outline, 'label': 'Delete Account'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isSentinel ? 'SETTINGS' : 'Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
            border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
            boxShadow: isSentinel
                ? [BoxShadow(color: extras?.glowColor ?? Colors.transparent, blurRadius: 6)]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items.asMap().entries.map((entry) {
              final item = entry.value;
              final isLast = entry.key == items.length - 1;
              final isDelete = item['label'] == 'Delete Account';

              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      item['icon'] as IconData,
                      color: isDelete ? Colors.red.shade400 : theme.colorScheme.onSurface,
                      size: 22,
                    ),
                    title: Text(
                      isSentinel
                          ? (item['label'] as String).toUpperCase()
                          : item['label'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDelete ? Colors.red.shade400 : null,
                        fontFamily: isSentinel ? 'FiraCode' : null,
                        letterSpacing: isSentinel ? 0.5 : 0,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.textTheme.bodyMedium?.color,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                  if (!isLast) Divider(height: 1, color: extras?.cardBorderColor),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
