import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'intro_screen.dart';
import 'api_key.dart';

void main() {
  Gemini.init(apiKey: GEMINI_API_KEY, enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyIntroScreen(),
    );
  }
}
