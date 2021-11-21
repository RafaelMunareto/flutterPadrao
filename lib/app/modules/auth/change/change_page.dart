import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/change/change_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';

class ChangePage extends StatefulWidget {
  final String title;
  const ChangePage({Key? key, this.title = 'ChangePage'}) : super(key: key);
  @override
  ChangePageState createState() => ChangePageState();
}
class ChangePageState extends State<ChangePage> {
  final ChangeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(title: widget.title, size: altura, context: context),
      body: Column(
        children: const <Widget>[],
      ),
    );
  }
}