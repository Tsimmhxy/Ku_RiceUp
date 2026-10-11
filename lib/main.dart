import 'package:flutter/material.dart';

import 'data/translations.dart';
import 'models/app_language.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const StickyRiceApp());
}

class StickyRiceApp extends StatelessWidget {
  const StickyRiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LanguageCode>(
      valueListenable: AppLanguage.current,
      builder: (context, language, _) {
        final lang = AppLanguage.code;

        return MaterialApp(
          title: T.get('appTitle', lang),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2E7D32),
            ),
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          home: const MainScreen(),
        );
      },
    );
  }
}
