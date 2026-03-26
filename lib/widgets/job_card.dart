import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';

class JobCard extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobCard({super.key, required this.job});

  Color _riskColor(String risk) {
    switch (risk) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.amber;
      default:
        return Colors.green;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'completed':
        return AppColors.statusSuccess;
      case 'unserved':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.read<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
        border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
        boxShadow: isSentinel
            ? [BoxShadow(color: extras?.glowColor ?? Colors.transparent, blurRadius: 6)]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status accent bar
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: _statusColor(job['status']),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(extras?.cardRadius ?? 12),
                topRight: Radius.circular(extras?.cardRadius ?? 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ID + Risk badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      job['id'],
                      style: theme.textTheme.labelSmall,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _riskColor(job['risk']).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        job['risk'],
                        style: TextStyle(
                          color: _riskColor(job['risk']),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Type
                Text(
                  job['type'],
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: isSentinel ? 'FiraCode' : null,
                    letterSpacing: isSentinel ? 1 : 0,
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                Text(
                  job['title'],
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                // Location + Date
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 14, color: theme.textTheme.bodyMedium?.color),
                    const SizedBox(width: 4),
                    Text(job['location'], style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
                    const Spacer(),
                    Icon(Icons.calendar_today_outlined,
                        size: 14, color: theme.textTheme.bodyMedium?.color),
                    const SizedBox(width: 4),
                    Text('${job['date']} | ${job['time']}',
                        style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                // Rate
                Row(
                  children: [
                    Text(
                      isSentinel ? 'MY RATE' : 'My Rate',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '\$${job['rate'].toStringAsFixed(0)}',
                      style: theme.textTheme.headlineSmall?.copyWith(fontSize: 20),
                    ),
                    Text(
                      '/hr',
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
