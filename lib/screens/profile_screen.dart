import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';
import '../data/mock_data.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/stat_badge.dart';
import '../widgets/sentinel_header.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'preferred_officer_screen.dart';
import 'help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SentinelHeader(),
              const SizedBox(height: 16),
              // Avatar
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSentinel
                      ? Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3), width: 2)
                      : null,
                  boxShadow: isSentinel
                      ? [BoxShadow(color: extras?.glowColor ?? Colors.transparent, blurRadius: 12)]
                      : null,
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: theme.colorScheme.surface,
                  child: Icon(Icons.person, size: 48, color: theme.textTheme.bodyMedium?.color),
                ),
              ),
              const SizedBox(height: 16),
              // Name + Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    MockData.profileName.toUpperCase(),
                    style: isSentinel
                        ? theme.textTheme.headlineSmall?.copyWith(fontSize: 18)
                        : theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isSentinel ? 'ELITE' : 'PREMIUM',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              if (isSentinel) ...[
                const SizedBox(height: 4),
                Text(
                  'ID: ${MockData.profileId}',
                  style: theme.textTheme.labelSmall,
                ),
              ],
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified, color: theme.colorScheme.primary, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    MockData.profileRole,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 12,
                      fontFamily: isSentinel ? 'FiraCode' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Stats
              Row(
                children: [
                  Expanded(
                    child: StatBadge(
                      label: isSentinel ? 'ACTIVE PROTOCOLS' : 'Active Protekts',
                      value: '${MockData.activeProtekts}',
                      icon: Icons.shield_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatBadge(
                      label: isSentinel ? 'TRUST SCORE' : 'Security Level',
                      value: '${MockData.trustScore}%',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Section label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  isSentinel ? 'COMMAND CENTER' : 'TACTICAL OPERATIONS',
                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 11),
                ),
              ),
              const SizedBox(height: 8),
              // Menu items
              ProfileMenuItem(
                icon: Icons.edit_outlined,
                label: 'Edit Profile',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen())),
              ),
              ProfileMenuItem(
                icon: Icons.work_outline,
                label: 'Job Posted',
                badge: 3,
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.star_outline,
                label: 'Preferred Officer',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PreferredOfficerScreen())),
              ),
              const Divider(height: 1),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    isSentinel ? 'SUPPORT & LEGAL' : 'SYSTEM PROTOCOLS',
                    style: theme.textTheme.labelSmall?.copyWith(fontSize: 11),
                  ),
                ),
              ),
              ProfileMenuItem(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen())),
              ),
              ProfileMenuItem(
                icon: Icons.help_outline,
                label: 'Help & Support',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HelpSupportScreen())),
              ),
              ProfileMenuItem(
                icon: Icons.description_outlined,
                label: 'T&C/Privacy Policy',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              // Logout
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade400,
                    side: BorderSide(color: Colors.red.shade400.withValues(alpha: 0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(isSentinel ? 'LOGOUT SYSTEM' : 'Logout'),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isSentinel ? 'SENTINEL PROTOCOL v2.4.1' : 'Version 2.0.0',
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
