import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'theme/theme_provider.dart';
import 'screens/theme_picker_screen.dart';
import 'widgets/iphone_frame.dart';

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

    final app = MaterialApp(
      title: 'On Call Protekt',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.theme,
      home: const ThemePickerScreen(),
    );

    // On web, wrap in iPhone mockup frame
    if (kIsWeb) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IPhoneFrame(child: app),
      );
    }

    return app;
  }
}
