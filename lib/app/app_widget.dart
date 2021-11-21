import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:flutter_padrao/app/shared/utils/themes/theme.dart';

class AppWidget extends StatefulWidget {
  @override
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
  static _AppWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppWidgetState>();
}

class _AppWidgetState extends State<AppWidget> {

  ThemeMode _themeMode = ThemeMode.system;
  final ILocalStorage theme = LocalStorageShare();
  late String darkLight = '';


  @override
  Widget build(BuildContext context) {

    theme.get('theme').then((value) {
      if(value != null){
        darkLight = value[0];
      }
    }).then((value) {
      darkLight == 'light' ? _themeMode = ThemeMode.light :  _themeMode = ThemeMode.dark;
    });

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