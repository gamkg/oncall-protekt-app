import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class PreferredOfficerScreen extends StatelessWidget {
  const PreferredOfficerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(isSentinel ? 'PREFERRED OFFICER' : 'Preferred Officer'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_search_outlined,
              size: 64,
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              isSentinel ? 'NO DATA AVAILABLE' : 'No Data Available',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color,
                fontFamily: isSentinel ? 'FiraCode' : null,
                letterSpacing: isSentinel ? 1 : 0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSentinel
                  ? 'Preferred officers will appear here'
                  : 'Preferred officers will appear here',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
