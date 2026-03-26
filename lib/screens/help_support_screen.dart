import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';
import '../data/mock_data.dart';
import '../widgets/sentinel_header.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(isSentinel ? 'SYSTEM SUPPORT CENTER' : 'Help & Support'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            if (isSentinel) const SentinelHeader(),
            // Header
            Text(
              isSentinel
                  ? 'How can we secure your operations?'
                  : 'Protekt Elite Support',
              style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
            ),
            if (!isSentinel) ...[
              const SizedBox(height: 4),
              Text(
                'Our technical specialists are online and ready to secure your digital infrastructure.',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
              ),
            ],
            const SizedBox(height: 16),
            // Chat CTA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.2),
                    AppColors.accent.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.chat_bubble_outline, color: AppColors.accent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSentinel ? 'Direct Response Channel' : 'Start Conversation',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isSentinel
                              ? 'Our Elite Security Engineers are online and ready to assist.'
                              : 'We typically reply in a few minutes',
                          style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.accent, size: 16),
                ],
              ),
            ),
            if (isSentinel) ...[
              const SizedBox(height: 8),
              Text(
                'SYSTEM ID: SYSTEM/NOMINAL',
                style: theme.textTheme.labelSmall?.copyWith(fontSize: 9),
              ),
              Text(
                '14:02 UTC - 08/10',
                style: theme.textTheme.labelSmall?.copyWith(fontSize: 9),
              ),
            ],
            const SizedBox(height: 24),
            // Search
            TextField(
              decoration: InputDecoration(
                hintText: isSentinel
                    ? 'Search documentation, security prot...'
                    : 'Search for documentation or s...',
                hintStyle: TextStyle(color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
                prefixIcon: Icon(Icons.search, color: theme.textTheme.bodyMedium?.color),
              ),
            ),
            const SizedBox(height: 24),
            // Active Inquiries
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isSentinel ? 'ACTIVE INQUIRIES' : 'Active Inquiries',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: theme.colorScheme.primary, fontSize: 12),
                  ),
                ),
              ],
            ),
            ...MockData.activeInquiries.map((inquiry) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                    border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(inquiry['title']!,
                                style: theme.textTheme.titleMedium?.copyWith(fontSize: 14)),
                            Text(inquiry['agent']!,
                                style: theme.textTheme.bodySmall?.copyWith(fontSize: 12)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: inquiry['status'] == 'active'
                              ? AppColors.accent.withValues(alpha: 0.15)
                              : Colors.grey.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          inquiry['status']!.toUpperCase(),
                          style: TextStyle(
                            color: inquiry['status'] == 'active' ? AppColors.accent : Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(inquiry['time']!, style: theme.textTheme.bodySmall),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            // Documentation
            Text(
              isSentinel ? 'DOCUMENTATION' : 'Documentation',
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _docItem(context, Icons.menu_book_outlined, 'User Manual',
                'Complete technical documentation for Sentinel hardware.', isSentinel),
            _docItem(context, Icons.gavel_outlined, 'Legal Policy',
                'Encryption standards, area coverages, and more.', isSentinel),
            _docItem(context, Icons.shield_outlined,
                isSentinel ? 'Privacy Shield' : 'Privacy Policy', '', isSentinel),
            const SizedBox(height: 24),
            // Bottom section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
              ),
              child: Column(
                children: [
                  Text(
                    isSentinel
                        ? 'Still need assistance?'
                        : 'Still need assistance?',
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isSentinel
                        ? 'Emergency Response Hotline'
                        : 'Emergency Response Hotline',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '6900-SENTINEL',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: isSentinel ? 'FiraCode' : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.onSurface,
                            side: BorderSide(color: extras?.cardBorderColor ?? Colors.grey),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12)),
                          ),
                          child: Text(isSentinel ? 'SUBMIT TICKET' : 'Submit Ticket',
                              style: const TextStyle(fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.onSurface,
                            side: BorderSide(color: extras?.cardBorderColor ?? Colors.grey),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12)),
                          ),
                          child: Text(isSentinel ? 'SYSTEM STATUS' : 'System Status',
                              style: const TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _docItem(BuildContext context, IconData icon, String title, String subtitle, bool isSentinel) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary, size: 22),
        title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontSize: 14)),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(fontSize: 12))
            : null,
        trailing: Icon(Icons.chevron_right, color: theme.textTheme.bodyMedium?.color, size: 20),
        tileColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
          side: BorderSide(color: extras?.cardBorderColor ?? Colors.transparent),
        ),
        onTap: () {},
      ),
    );
  }
}
