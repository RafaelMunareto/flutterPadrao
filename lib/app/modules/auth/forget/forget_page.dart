import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/forget/forget_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';
import 'package:flutter_padrao/app/shared/components/text_field_widget.dart';
import 'package:flutter_padrao/app/shared/utils/snackbar_custom.dart';
import 'package:mobx/mobx.dart';

class ForgetPage extends StatefulWidget {
  final String title;
  const ForgetPage({Key? key, this.title = 'Esqueceu a senha'}) : super(key: key);
  @override
  ForgetPageState createState() => ForgetPageState();
}
class ForgetPageState extends State<ForgetPage> {
  final ForgetStore store = Modular.get();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun((_) {
      if (store.msgErro != '') {
        SnackbarCustom()
            .createSnackBar(store.msgErro, Colors.red, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title, size: altura, context: context, back: false),
      body: LayoutBuilder(builder: (context, constraint) {
        var largura = constraint.maxWidth;
        if (largura < 600) {
          largura = largura * 1;
        } else if (largura < 768) {
          largura = largura * 0.6;
        } else if (largura < 1024) {
          largura = largura * 0.4;
        } else {
          largura = largura * 0.2;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                width: largura,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFieldWidget(
                        labelText: 'email',
                        onChanged: store.client.changeEmail,
                        errorText: store.client.validateEmail),
                    const SizedBox(
                      height: 20,
                    ),
                    Observer(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 24, 8, 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          onPressed:
                          store.client.isValidLogin ? store.submit : null,
                          child: store.loading ?  CircularProgressIndicator(color: Colors.white,) : Text('ENVIAR SENHA'),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
