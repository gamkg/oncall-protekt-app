import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';

class PreferredOfficerScreen extends StatelessWidget {
  const PreferredOfficerScreen({super.key});

  static const _officers = [
    {'name': 'Marcus Cole', 'rank': 'Senior Officer', 'rating': 4.9, 'jobs': 87, 'status': 'available'},
    {'name': 'Diana Reeves', 'rank': 'Lead Specialist', 'rating': 4.8, 'jobs': 124, 'status': 'on-duty'},
    {'name': 'James Ortega', 'rank': 'Field Agent', 'rating': 4.7, 'jobs': 56, 'status': 'available'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(isSentinel ? 'PREFERRED OFFICERS' : 'Preferred Officer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isSentinel ? 'YOUR ELITE TEAM' : 'Your preferred officers',
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isSentinel
                  ? 'Officers you have marked as preferred for priority assignment.'
                  : 'Officers you have marked as preferred for priority assignment.',
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 16),
            ..._officers.map((officer) => _buildOfficerCard(context, officer, theme, extras, isSentinel)),
            const SizedBox(height: 24),
            // Add officer button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.person_add_outlined, color: theme.colorScheme.primary),
                label: Text(
                  isSentinel ? 'ADD OFFICER' : 'Add Preferred Officer',
                  style: TextStyle(
                    fontFamily: isSentinel ? 'FiraCode' : null,
                    letterSpacing: isSentinel ? 1 : 0,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficerCard(
    BuildContext context,
    Map<String, dynamic> officer,
    ThemeData theme,
    AppThemeExtras? extras,
    bool isSentinel,
  ) {
    final isAvailable = officer['status'] == 'available';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
        border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
        boxShadow: isSentinel
            ? [BoxShadow(color: extras?.glowColor ?? Colors.transparent, blurRadius: 6)]
            : null,
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
            child: Text(
              officer['name'].toString().split(' ').map((w) => w[0]).join(),
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                fontFamily: isSentinel ? 'FiraCode' : null,
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSentinel ? officer['name'].toString().toUpperCase() : officer['name'].toString(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: isSentinel ? 'FiraCode' : null,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  officer['rank'].toString(),
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, color: theme.colorScheme.primary, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${officer['rating']}',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.work_outline, color: theme.textTheme.bodyMedium?.color, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${officer['jobs']} jobs',
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Status + action
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? AppColors.statusSuccess.withValues(alpha: 0.15)
                      : AppColors.statusInfo.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isAvailable
                      ? (isSentinel ? 'ONLINE' : 'Available')
                      : (isSentinel ? 'ON DUTY' : 'On Duty'),
                  style: TextStyle(
                    color: isAvailable ? AppColors.statusSuccess : AppColors.statusInfo,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontFamily: isSentinel ? 'FiraCode' : null,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Icon(Icons.chevron_right, color: theme.textTheme.bodyMedium?.color, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
