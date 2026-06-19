import 'package:calc_cafe/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'ui/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class ThemeController {
  static final ValueNotifier<ThemeMode> theme =
      ValueNotifier(ThemeMode.light);

  static void toggleTheme() {
    theme.value =
        theme.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
  }
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
      darkTheme: ThemeApp.dark(),
      themeMode: ThemeMode.system,

      home: HomePage(),
    );
  }
}
