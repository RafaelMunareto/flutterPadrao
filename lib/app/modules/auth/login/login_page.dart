import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';
import 'package:flutter_padrao/app/shared/components/button_widget.dart';
import 'package:flutter_padrao/app/shared/components/link_rote_widget.dart';
import 'package:flutter_padrao/app/shared/components/text_field_widget.dart';
import 'package:flutter_padrao/app/shared/utils/snackbar_custom.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun(
      (_) {
        if(store.msg != ''){
          SnackbarCustom().createSnackBareErrOrGoal(_scaffoldKey, message:store.msg, errOrGoal:store.errOrGoal);
          store.setMsg('');
        }
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      key: _scaffoldKey,
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
              child: SizedBox(
                width: largura,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFieldWidget(
                        labelText: 'E-mail',
                        onChanged: store.client.changeEmail,
                        errorText: store.client.validateEmail),
                    TextFieldWidget(
                        labelText: 'Senha',
                        obscure: true,
                        onChanged: store.client.changePassword,
                        errorText: store.client.validatePassword),
                    Observer(builder: (_) {
                      return ButtonWidget(
                          label: 'LOGIN',
                          loading: store.loading,
                          function:
                              store.client.isValidLogin ? store.submit : null);
                    }),
                    const LinkRoteWidget(
                        labelBold: 'Esqueceu a senha', rota: '/auth/forget'),
                    const LinkRoteWidget(
                        label: 'Não possui cadastro? ',
                        labelBold: 'Registre-se',
                        rota: '/auth/signup')
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
