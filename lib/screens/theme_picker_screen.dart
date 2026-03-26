import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';
import 'sign_in_screen.dart';

class ThemePickerScreen extends StatelessWidget {
  const ThemePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),
              // Logo
              Image.asset('assets/ocp-logo.png', height: 100),
              const SizedBox(height: 24),
              const Text(
                'ON CALL PROTEKT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose Your Experience',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 48),
              // Dark Mode card
              _ThemeCard(
                title: 'Dark Mode',
                subtitle: 'Clean. Premium. Modern.',
                accentOpacity: 0.1,
                showGlow: false,
                onTap: () {
                  context.read<ThemeProvider>().setTheme(AppThemeMode.darkMode);
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const SignInScreen(),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                      transitionDuration: const Duration(milliseconds: 200),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Sentinel Dark card
              _ThemeCard(
                title: 'Sentinel Dark',
                subtitle: 'Tactical. Secure. Elite.',
                accentOpacity: 0.2,
                showGlow: true,
                onTap: () {
                  context.read<ThemeProvider>().setTheme(AppThemeMode.sentinelDark);
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const SignInScreen(),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                      transitionDuration: const Duration(milliseconds: 200),
                    ),
                  );
                },
              ),
              const Spacer(),
              Text(
                'MVP Preview Build',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double accentOpacity;
  final bool showGlow;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.title,
    required this.subtitle,
    required this.accentOpacity,
    required this.showGlow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: showGlow ? const Color(0xFF161B22) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(showGlow ? 8 : 12),
          border: Border.all(
            color: showGlow
                ? AppColors.accent.withValues(alpha: 0.3)
                : const Color(0xFF2A2A2A),
          ),
          boxShadow: showGlow
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: accentOpacity),
                    borderRadius: BorderRadius.circular(showGlow ? 4 : 8),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(Icons.palette, color: AppColors.accent, size: 20),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: showGlow ? 'FiraCode' : null,
                        letterSpacing: showGlow ? 1 : 0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, color: Color(0xFF9CA3AF), size: 16),
              ],
            ),
            const SizedBox(height: 16),
            // Mini color preview
            Row(
              children: [
                _colorDot(showGlow ? const Color(0xFF0D1117) : const Color(0xFF0A0A0A)),
                _colorDot(showGlow ? const Color(0xFF161B22) : const Color(0xFF1A1A1A)),
                _colorDot(AppColors.accent),
                _colorDot(Colors.white),
                _colorDot(const Color(0xFF9CA3AF)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorDot(Color color) {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24, width: 1),
      ),
    );
  }
}
