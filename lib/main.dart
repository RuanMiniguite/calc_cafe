import 'package:calc_cafe/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'ui/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static const String _title = 'Pilagem de Café';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeApp.light(),
      themeMode: ThemeMode.light,
      home: HomePage(),
    );
  }
}