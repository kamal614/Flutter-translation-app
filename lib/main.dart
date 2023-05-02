import 'package:flutter/material.dart';
import 'package:flutter_translations/translations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LanguageTranslatorApp(),
    );
  }
}
