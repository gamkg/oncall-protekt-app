import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class ThemeTogglePill extends StatelessWidget {
  const ThemeTogglePill({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    return GestureDetector(
      onTap: () => tp.toggle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF00E5CC), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.swap_horiz, color: Color(0xFF00E5CC), size: 14),
            const SizedBox(width: 4),
            Text(
              tp.otherLabel,
              style: const TextStyle(
                color: Color(0xFF00E5CC),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
