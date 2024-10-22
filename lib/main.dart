import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'intro_screen.dart';
import 'api_key.dart';

void main() {
  Gemini.init(apiKey: GEMINI_API_KEY, enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState of(BuildContext context) =>
    context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyIntroScreen(),
      themeMode: _themeMode,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
    );
  }
  void changeTheme(ThemeMode themeMode){
    setState((){
      _themeMode = themeMode;
      }
    );
  }
}
