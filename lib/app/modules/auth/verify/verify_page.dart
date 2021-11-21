import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/verify/verify_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';

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
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(title: widget.title, size: altura, context: context),
      body: Column(
        children: const <Widget>[],
      ),
    );
  }
}