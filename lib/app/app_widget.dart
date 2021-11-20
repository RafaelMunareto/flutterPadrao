import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/utils/themes/theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Padrão',
      debugShowCheckedModeBanner: false,
      initialRoute: "/auth",
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
    ).modular();
  }
}