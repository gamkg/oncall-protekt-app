import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';
import '../widgets/theme_toggle_pill.dart';
import 'app_shell.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  // Logo
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSentinel
                          ? Border.all(color: AppColors.accent.withValues(alpha: 0.3), width: 2)
                          : null,
                      boxShadow: isSentinel
                          ? [BoxShadow(color: extras?.glowColor ?? Colors.transparent, blurRadius: 20)]
                          : null,
                    ),
                    child: Image.asset('assets/ocp-logo.png', height: 80),
                  ),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    isSentinel ? 'SENTINEL LOGIN' : 'Welcome Back',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: isSentinel ? 22 : 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isSentinel
                        ? 'SECURE ACCESS GATEWAY \u2022 LEVEL 4 CLEARANCE'
                        : 'Sign in to continue',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: isSentinel ? 11 : 14,
                      letterSpacing: isSentinel ? 1 : 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Email field
                  _buildLabel(context, isSentinel ? 'DEPLOYMENT EMAIL' : 'Email', isSentinel),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'operator@protekt.elite',
                      hintStyle: TextStyle(color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
                      prefixIcon: Icon(
                        isSentinel ? Icons.alternate_email : Icons.email_outlined,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  // Password field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLabel(context, isSentinel ? 'ACCESS KEY' : 'Password', isSentinel),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          isSentinel ? 'RECOVER KEY' : 'Forgot Password?',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 12,
                            fontFamily: isSentinel ? 'FiraCode' : null,
                            letterSpacing: isSentinel ? 1 : 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: isSentinel ? '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022' : '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
                      hintStyle: TextStyle(color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
                      prefixIcon: Icon(
                        isSentinel ? Icons.vpn_key_outlined : Icons.lock_outline,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  // CTA Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const AppShell(),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                            transitionDuration: const Duration(milliseconds: 200),
                          ),
                        );
                      },
                      child: Text(isSentinel ? 'ESTABLISH CONNECTION' : 'Sign In'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Alternative auth
                  Text(
                    isSentinel ? 'ALTERNATIVE AUTHENTICATION' : 'Or continue with',
                    style: theme.textTheme.bodySmall?.copyWith(
                      letterSpacing: isSentinel ? 1.5 : 0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.fingerprint,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text(
                      isSentinel ? 'IDENTITY SYNC' : 'Biometric Login',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontFamily: isSentinel ? 'FiraCode' : null,
                        letterSpacing: isSentinel ? 1 : 0,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: extras?.cardBorderColor ?? Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(extras?.cardRadius ?? 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Bottom text
                  Text.rich(
                    TextSpan(
                      text: isSentinel ? 'NEW OPERATOR? ' : 'New operator? ',
                      style: theme.textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: isSentinel ? 'REQUEST ACCESS' : 'Request access',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSentinel) ...[
                    const SizedBox(height: 32),
                    // Sentinel status bar
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: extras?.cardBorderColor ?? Colors.transparent),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _statusItem(context, 'SYSTEM\nONLINE', Colors.green),
                          _statusItem(context, 'ENCRYPTION\nv4.2.0', AppColors.accent),
                          _statusItem(context, 'PROXY\nPROTECTED', AppColors.accent),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 50,
            right: 16,
            child: ThemeTogglePill(),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text, bool isSentinel) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: isSentinel ? 'FiraCode' : null,
          letterSpacing: isSentinel ? 1.5 : 0.5,
        ),
      ),
    );
  }

  Widget _statusItem(BuildContext context, String text, Color dotColor) {
    return Column(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: dotColor.withValues(alpha: 0.5), blurRadius: 4)],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF8B949E),
            fontFamily: 'FiraCode',
            fontSize: 9,
            letterSpacing: 0.5,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
