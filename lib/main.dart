import 'package:flutter/material.dart';
import 'intro_screen.dart';

void main() {
  runApp(MyApp());
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
