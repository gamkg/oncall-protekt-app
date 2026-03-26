import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import '../theme/app_themes.dart';
import '../data/mock_data.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extras = theme.extension<AppThemeExtras>();
    final isSentinel =
        context.watch<ThemeProvider>().mode == AppThemeMode.sentinelDark;

    return Scaffold(
      appBar: AppBar(
        title: Text(isSentinel ? 'EDIT PROFILE' : 'Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Avatar with camera
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isSentinel
                        ? Border.all(color: AppColors.accent.withValues(alpha: 0.3), width: 2)
                        : null,
                  ),
                  child: CircleAvatar(
                    radius: 52,
                    backgroundColor: theme.colorScheme.surface,
                    child: Icon(Icons.person, size: 52, color: theme.textTheme.bodyMedium?.color),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, size: 16, color: theme.scaffoldBackgroundColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _field(context, isSentinel ? 'NAME' : 'Name', MockData.profileName, isSentinel),
            const SizedBox(height: 20),
            _field(context, isSentinel ? 'MOBILE NUMBER' : 'Mobile Number', MockData.profilePhone, isSentinel),
            const SizedBox(height: 20),
            _field(context, isSentinel ? 'EMAIL' : 'Email', MockData.profileEmail, isSentinel),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(isSentinel ? 'UPDATE' : 'Update'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _field(BuildContext context, String label, String value, bool isSentinel) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.textTheme.bodyMedium?.color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: isSentinel ? 'FiraCode' : null,
            letterSpacing: isSentinel ? 1.5 : 0.5,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
