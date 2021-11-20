import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/change/change_store.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}