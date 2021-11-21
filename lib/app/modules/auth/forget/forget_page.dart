import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/forget/forget_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';

class ForgetPage extends StatefulWidget {
  final String title;
  const ForgetPage({Key? key, this.title = 'ForgetPage'}) : super(key: key);
  @override
  ForgetPageState createState() => ForgetPageState();
}
class ForgetPageState extends State<ForgetPage> {
  final ForgetStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(title: widget.title, size: altura, context: context),
      body: Column(
        children: const [

        ],
      ),
    );
  }
}