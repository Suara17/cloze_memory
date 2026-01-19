import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cloze_provider_simple.dart';
import 'screens/home_screen_simple.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClozeProvider()),
      ],
      child: const ClozeMemoryApp(),
    ),
  );
}

class ClozeMemoryApp extends StatelessWidget {
  const ClozeMemoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '挖空背书',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Noto Sans SC',
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}