import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/utils/themes/theme.dart';

class AppWidget extends StatefulWidget {
  @override
  State<AppWidget> createState() => _AppWidgetState();
  static _AppWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppWidgetState>();
}

class _AppWidgetState extends State<AppWidget> {
  ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Padrão',
      debugShowCheckedModeBanner: false,
      initialRoute: "/auth",
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeMode,
    ).modular();
  }
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}