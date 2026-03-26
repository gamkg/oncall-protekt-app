import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class SentinelHeader extends StatelessWidget {
  final String? subtitle;

  const SentinelHeader({super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    if (!isSentinel) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF00E5CC),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E5CC).withValues(alpha: 0.5),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'SENTINEL',
            style: TextStyle(
              color: const Color(0xFF00E5CC),
              fontFamily: 'FiraCode',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              shadows: [
                Shadow(
                  color: const Color(0xFF00E5CC).withValues(alpha: 0.5),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          if (subtitle != null) ...[
            const Spacer(),
            Text(
              subtitle!,
              style: const TextStyle(
                color: Color(0xFF8B949E),
                fontFamily: 'FiraCode',
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
