import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const googleTranslateAPIKey =
    "YOUR_API_KEY_HERE"; // Replace with your own API key

class LanguageTranslatorApp extends StatefulWidget {
  @override
  _LanguageTranslatorAppState createState() => _LanguageTranslatorAppState();
}

class _LanguageTranslatorAppState extends State<LanguageTranslatorApp> {
  String _selectedFromLanguage = "en";
  String _selectedToLanguage = "es";
  String _textToTranslate = "";
  String _translatedText = "";

  final List<String> _languages = [
    "en",
    "es",
    "fr",
    "de",
    "hi",
    "it",
    "ja",
    "ko",
    "pt",
    "ru",
    "zh-CN",
  ];

  Future<String> _translate(String text, String from, String to) async {
    //callig api here
    final response = await http.get(Uri.parse(
        "https://translation.googleapis.com/language/translate/v2?key=$googleTranslateAPIKey&q=$text&source=$from&target=$to"));
    final data = jsonDecode(response.body);
    return data["data"]["translations"][0]["translatedText"];
  }

  void _translateText() async {
    String translatedText = await _translate(
        _textToTranslate, _selectedFromLanguage, _selectedToLanguage);
    setState(() {
      _translatedText = translatedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Translator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Enter text to translate",
                  border: OutlineInputBorder(),
                ),
                onChanged: (userKaText) {
                  setState(() {
                    _textToTranslate = userKaText;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _selectedFromLanguage,
                  onChanged: (language) {
                    setState(() {
                      _selectedFromLanguage = language!;
                    });
                  },
                  items: _languages
                      .map((language) => DropdownMenuItem(
                            value: language,
                            child: Text(language),
                          ))
                      .toList(),
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _selectedToLanguage,
                  onChanged: (language) {
                    setState(() {
                      _selectedToLanguage = language!;
                    });
                  },
                  items: _languages
                      .map((language) => DropdownMenuItem(
                            value: language,
                            child: Text(language),
                          ))
                      .toList(),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _translateText,
              child: const Text("Translate"),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              _translatedText,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
