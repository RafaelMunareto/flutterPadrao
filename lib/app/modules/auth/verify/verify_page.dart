import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/verify/verify_store.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget {
  final String title;
  const VerifyPage({Key? key, this.title = 'VerifyPage'}) : super(key: key);
  @override
  VerifyPageState createState() => VerifyPageState();
}
class VerifyPageState extends State<VerifyPage> {
  final VerifyStore store = Modular.get();

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