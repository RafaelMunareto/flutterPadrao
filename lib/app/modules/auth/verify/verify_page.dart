import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/change/change_page.dart';
import 'package:flutter_padrao/app/modules/auth/verify/verify_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';
import 'package:flutter_padrao/app/shared/utils/snackbar_custom.dart';
import 'package:mobx/mobx.dart';

class VerifyPage extends StatefulWidget {
  final String title;

  const VerifyPage({Key? key, this.title = 'Email Verificação'})
      : super(key: key);

  @override
  VerifyPageState createState() => VerifyPageState();
}

class VerifyPageState extends State<VerifyPage> {
  final VerifyStore store = Modular.get();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    store.emailVerify();
    store.verificaTipo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
          (_) {
        if(store.msg != ''){
          SnackbarCustom().createSnackBareErrOrGoal(_scaffoldKey, message:store.msg, errOrGoal:store.msgErrOrGoal, rota: '/auth');
          store.setMsg('');
        }
      },

    );
  }

  _card(tipo, color) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          tipo + ' ' + store.msg, style: TextStyle(color: color, fontSize: 24),),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery
        .of(context)
        .size
        .height * 0.2;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(title: store.tipo != 'verifyEmail' ? 'Trocar Senha': widget.title, size: altura, context: context),
      body: store.tipo != 'verifyEmail' ? const ChangePage() : Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              child: store.msg != 'Email validado com Sucesso!' ? _card('Erro!', Colors.red) : _card('Sucesso!', Colors.green)
          ),
        ]),
      ),
    );
  }
}
