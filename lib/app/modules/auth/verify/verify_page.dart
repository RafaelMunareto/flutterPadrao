import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/verify/verify_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';

class VerifyPage extends StatefulWidget {
  final String title;
  final String code;

  const VerifyPage(
      {Key? key, this.title = 'Verificação de email', this.code = ''})
      : super(key: key);

  @override
  VerifyPageState createState() => VerifyPageState();
}

class VerifyPageState extends State<VerifyPage> {
  final VerifyStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.setCode(widget.code);
    store.emailVerify();
  }

  _card() {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            store.msg,
            style: TextStyle(
                color: store.msgErrOrGoal ? Colors.green : Colors.red,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(title: widget.title, size: altura, context: context),
      body: Observer(builder: (_) {
        return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(child: store.msg != '' ? _card() : Container()),
          ]),
        );
      }),
    );
  }
}
