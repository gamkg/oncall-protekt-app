import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme_provider.dart';
import 'screens/theme_picker_screen.dart';

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
    return MaterialApp(
      title: 'On Call Protekt',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.theme,
      home: const ThemePickerScreen(),
    );
  }
}
