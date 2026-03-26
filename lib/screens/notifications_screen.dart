import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';
import '../data/mock_data.dart';
import '../widgets/notification_card.dart';
import '../widgets/sentinel_header.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    final today = MockData.notifications.sublist(0, 3);
    final yesterday = MockData.notifications.sublist(3);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const SentinelHeader(subtitle: 'LIVE FEED'),
              // Title
              Text(
                isSentinel ? 'COMMAND CENTER' : 'System Alerts',
                style: theme.textTheme.headlineMedium?.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 4),
              Text(
                isSentinel
                    ? 'REAL-TIME ENVIRONMENTAL & OPERATIONAL AWARENESS'
                    : 'Monitoring real-time network and physical asset security protocols.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: isSentinel ? 10 : 13,
                  letterSpacing: isSentinel ? 1 : 0,
                ),
              ),
              const SizedBox(height: 16),
              // Sentinel filter chips
              if (isSentinel) ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Security', 'System', 'Jobs', 'Alerts']
                        .map((label) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(label,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'FiraCode',
                                      color: label == 'All'
                                          ? theme.scaffoldBackgroundColor
                                          : theme.textTheme.bodyMedium?.color,
                                    )),
                                selected: label == 'All',
                                selectedColor: AppColors.accent,
                                backgroundColor: theme.colorScheme.surface,
                                side: BorderSide(
                                    color: extras?.cardBorderColor ?? Colors.transparent),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                onSelected: (_) {},
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Today section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isSentinel ? 'TODAY' : 'Today',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      isSentinel ? 'MARK ALL READ' : 'Mark all read',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                        fontFamily: isSentinel ? 'FiraCode' : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...today.map((n) => NotificationCard(notification: n)),
              const SizedBox(height: 16),
              // Yesterday section
              Text(
                isSentinel ? 'YESTERDAY' : 'Yesterday',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...yesterday.map((n) => NotificationCard(notification: n)),
              // Sentinel threat level
              if (isSentinel) ...[
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
                  ),
                  child: Column(
                    children: [
                      Text('SENTINEL SYSTEM STATUS',
                          style: theme.textTheme.labelSmall?.copyWith(fontSize: 10)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('${MockData.trustScore}%',
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    fontSize: 28,
                                    color: AppColors.accent,
                                  )),
                              const SizedBox(height: 4),
                              Text('TRUST SCORE',
                                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: extras?.cardBorderColor,
                          ),
                          Column(
                            children: [
                              Text('LOW',
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    fontSize: 28,
                                    color: Colors.green,
                                  )),
                              const SizedBox(height: 4),
                              Text('THREAT LEVEL',
                                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
