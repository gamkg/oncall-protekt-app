import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';
import '../data/mock_data.dart';
import '../widgets/job_card.dart';
import '../widgets/sentinel_header.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _filterJobs(String status) {
    return MockData.jobs.where((j) => j['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const SentinelHeader(),
              // Earnings summary (Sentinel)
              if (isSentinel) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
                    boxShadow: [
                      BoxShadow(color: extras?.glowColor ?? Colors.transparent, blurRadius: 8),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SUBJECT EXECUTIVE BUNDLE',
                              style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)),
                          const SizedBox(height: 4),
                          Text('\$12,840.00',
                              style: theme.textTheme.headlineMedium?.copyWith(fontSize: 24)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: theme.colorScheme.primary, size: 14),
                            const SizedBox(width: 4),
                            Text('${MockData.rating}',
                                style: TextStyle(
                                    color: theme.colorScheme.primary, fontFamily: 'FiraCode', fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Title (Dark Mode)
              if (!isSentinel) ...[
                Text('My Jobs', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 4),
                Text(
                  'Reviewing your deployment history and service performance metrics within the Protekt Elite network.',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 16),
              ] else ...[
                Text('My Jobs', style: theme.textTheme.titleLarge?.copyWith(fontSize: 20)),
                const SizedBox(height: 12),
              ],
              // Tabs
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.textTheme.bodyMedium?.color,
                  indicatorColor: theme.colorScheme.primary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    fontFamily: isSentinel ? 'FiraCode' : null,
                    letterSpacing: isSentinel ? 0.5 : 0,
                  ),
                  tabs: [
                    Tab(text: isSentinel ? 'COMPLETED' : 'Completed'),
                    Tab(text: isSentinel ? 'UNSERVED' : 'Unserved'),
                    Tab(text: isSentinel ? 'CANCELLED' : 'Cancelled'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Job list
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildJobList(_filterJobs('completed'), isSentinel),
                    _buildJobList(_filterJobs('unserved'), isSentinel),
                    _buildJobList(_filterJobs('cancelled'), isSentinel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobList(List<Map<String, dynamic>> jobs, bool isSentinel) {
    if (jobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.work_off_outlined,
                size: 48, color: Theme.of(context).textTheme.bodyMedium?.color),
            const SizedBox(height: 12),
            Text('No jobs found', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      );
    }
    return ListView(
      children: [
        ...jobs.map((job) => JobCard(job: job)),
        if (jobs.first['status'] == 'completed') _buildStats(isSentinel),
      ],
    );
  }

  Widget _buildStats(bool isSentinel) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      child: Row(
        children: [
          _statItem(theme, isSentinel ? 'COMPLETION' : 'Completion', '${MockData.completionRate}%'),
          const SizedBox(width: 12),
          _statItem(theme, isSentinel ? 'TOTAL JOBS' : 'Total Jobs', '${MockData.totalJobs}'),
          const SizedBox(width: 12),
          _statItem(theme, isSentinel ? 'RELIABILITY' : 'Reliability', 'A+'),
          const SizedBox(width: 12),
          _statItem(theme, isSentinel ? 'RATING' : 'Rating', '${MockData.rating}'),
        ],
      ),
    );
  }

  Widget _statItem(ThemeData theme, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18)),
          const SizedBox(height: 2),
          Text(label, style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)),
        ],
      ),
    );
  }
}
