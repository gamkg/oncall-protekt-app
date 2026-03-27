import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';
import '../screens/sign_in_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/my_jobs_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/preferred_officer_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/help_support_screen.dart';
import '../screens/app_shell.dart';
import 'iphone_frame.dart';

class _ScreenEntry {
  final String label;
  final Widget screen;

  const _ScreenEntry({required this.label, required this.screen});
}

class WebPreviewShell extends StatefulWidget {
  const WebPreviewShell({super.key});

  @override
  State<WebPreviewShell> createState() => _WebPreviewShellState();
}

class _WebPreviewShellState extends State<WebPreviewShell> {
  int _activeIndex = 0;

  late final List<_ScreenEntry> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      _ScreenEntry(label: 'Login', screen: const SignInScreen()),
      _ScreenEntry(label: 'Notifications', screen: const NotificationsScreen()),
      _ScreenEntry(label: 'My Jobs', screen: const AppShell()),
      _ScreenEntry(label: 'Profile', screen: const ProfileScreen()),
      _ScreenEntry(label: 'Edit Profile', screen: const EditProfileScreen()),
      _ScreenEntry(label: 'Preferred Officer', screen: const PreferredOfficerScreen()),
      _ScreenEntry(label: 'Settings', screen: const SettingsScreen()),
      _ScreenEntry(label: 'Help & Support', screen: const HelpSupportScreen()),
    ];
  }

  static const _accent = Color(0xFFFACC15);
  static const _onAccent = Color(0xFF0B1121);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return isMobile ? _buildMobile(context) : _buildDesktop(context);
      },
    );
  }

  // ──────────────────────────────────────────────
  // MOBILE LAYOUT
  // ──────────────────────────────────────────────
  Widget _buildMobile(BuildContext context) {
    final tp = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Compact header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'OCP - ${tp.label}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // 2 CTA buttons
                  _themeButton(
                    label: 'Dark',
                    isActive: tp.mode == AppThemeMode.darkMode,
                    onTap: () => tp.setTheme(AppThemeMode.darkMode),
                    compact: true,
                  ),
                  const SizedBox(width: 6),
                  _themeButton(
                    label: 'Sentinel',
                    isActive: tp.mode == AppThemeMode.sentinelDark,
                    onTap: () => tp.setTheme(AppThemeMode.sentinelDark),
                    compact: true,
                  ),
                ],
              ),
            ),
            // Horizontal scrollable screen tabs
            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _screens.length,
                itemBuilder: (context, index) {
                  final isActive = index == _activeIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => setState(() => _activeIndex = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isActive ? _accent : Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isActive
                                ? _accent
                                : const Color(0x33FFFFFF),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isActive ? _onAccent : const Color(0xFF666666),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _screens[index].label,
                              style: TextStyle(
                                color: isActive ? _onAccent : const Color(0xFF999999),
                                fontSize: 12,
                                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // App content - no phone frame, just the screen
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: tp.theme,
                  home: _screens[_activeIndex].screen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────
  // DESKTOP LAYOUT
  // ──────────────────────────────────────────────
  Widget _buildDesktop(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final totalScreens = _screens.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Column(
        children: [
          // Top header bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0x14FFFFFF)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OCP App Redesign - ${tp.label}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Flutter MVP Preview',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                _themeButton(
                  label: 'Dark Mode',
                  isActive: tp.mode == AppThemeMode.darkMode,
                  onTap: () => tp.setTheme(AppThemeMode.darkMode),
                ),
                const SizedBox(width: 10),
                _themeButton(
                  label: 'Sentinel Dark',
                  isActive: tp.mode == AppThemeMode.sentinelDark,
                  onTap: () => tp.setTheme(AppThemeMode.sentinelDark),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: _accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_activeIndex + 1} / $totalScreens',
                    style: const TextStyle(
                      color: _onAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main content: sidebar + phone frame
          Expanded(
            child: Row(
              children: [
                // Sidebar
                Container(
                  width: 220,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0x0FFFFFFF)),
                    ),
                  ),
                  child: Column(
                    children: _screens.asMap().entries.map((entry) {
                      final index = entry.key;
                      final screen = entry.value;
                      final isActive = index == _activeIndex;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: GestureDetector(
                          onTap: () => setState(() => _activeIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? _accent.withValues(alpha: 0.09)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isActive
                                    ? _accent.withValues(alpha: 0.19)
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? _accent
                                        : const Color(0x0FFFFFFF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: isActive
                                          ? _onAccent
                                          : const Color(0xFF666666),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    screen.label,
                                    style: TextStyle(
                                      color: isActive
                                          ? _accent
                                          : const Color(0xFF888888),
                                      fontSize: 13,
                                      fontWeight:
                                          isActive ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Phone frame area
                Expanded(
                  child: IPhoneFrame(
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: tp.theme,
                      home: _screens[_activeIndex].screen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeButton({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    bool compact = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 12 : 20,
          vertical: compact ? 7 : 10,
        ),
        decoration: BoxDecoration(
          color: isActive ? _accent : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? _accent : _accent.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? _onAccent : _accent,
            fontSize: compact ? 12 : 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
