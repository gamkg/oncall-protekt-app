import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'theme/theme_provider.dart';
import 'screens/theme_picker_screen.dart';
import 'widgets/web_preview_shell.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const OnCallProtektApp(),
    ),
  );
}

class OnCallProtektApp extends StatelessWidget {
  const OnCallProtektApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    // On web, use the full preview shell with sidebar tabs + phone frame
    if (kIsWeb) {
      return MaterialApp(
        title: 'On Call Protekt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const WebPreviewShell(),
      );
    }

    return MaterialApp(
      title: 'On Call Protekt',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.theme,
      home: const ThemePickerScreen(),
    );
  }
}
