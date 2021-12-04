import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/signup/signup_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';
import 'package:flutter_padrao/app/shared/components/button_widget.dart';
import 'package:flutter_padrao/app/shared/components/cursor_pointer_widget.dart';
import 'package:flutter_padrao/app/shared/components/link_rote_widget.dart';
import 'package:flutter_padrao/app/shared/components/text_field_widget.dart';
import 'package:flutter_padrao/app/shared/utils/snackbar_custom.dart';
import 'package:mobx/mobx.dart';

class SignupPage extends StatefulWidget {
  final String title;

  const SignupPage({Key? key, this.title = 'Registre-se'}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final SignupStore store = Modular.get();
  bool _hover = false;

  @override
  void initState() {
    store.setGrupoEmail();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun((_) {
      if (store.checkGrupoEmail!) {
        if (store.msgFirebase != '') {
          store.loading = false;
          SnackbarCustom()
              .createSnackBar(store.msgFirebase, Colors.red, context);
        }
      } else {
        if (store.msgFirebase != '') {
          store.loading = false;
          SnackbarCustom()
              .createSnackBar(store.msgFirebase, Colors.green, context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery
        .of(context)
        .size
        .height * 0.2;
    return Scaffold(
        appBar: AppBarWidget(
            title: widget.title, size: altura, context: context),
        body: LayoutBuilder(
              builder: (context, constraint) {

                var largura = constraint.maxWidth;
                if( largura < 600 ){
                  largura = largura * 1;
                }else if( largura < 768 ) {
                  largura = largura * 0.6;
                }else if( largura < 1024 ) {
                  largura = largura * 0.4;
                }else{
                  largura = largura * 0.2;
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: Center(
                      child: SizedBox(
                        width: largura,
                        child: Column(
                          children: [
                            TextFieldWidget(
                                labelText: 'name',
                                onChanged: store.client.changeName,
                                errorText: store.client.validateName),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                                labelText: 'email',
                                onChanged: store.changeEmailGrupo,
                                errorText: store.validateEmailGrupo),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                                labelText: 'Password',
                                obscure: true,
                                onChanged: store.client.changePassword,
                                errorText: store.client.validatePassword),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                                labelText: 'Confirm Password',
                                obscure: true,
                                onChanged: store.client.changeConfirmPassword,
                                errorText: store.client.validateConfirmPassword),
                            Observer(builder: (_) {
                              return ButtonWidget(label: 'CADASTRAR', function: store.isValidRegisterEmailGrupo ? store.submit : null);
                            }),
                            const LinkRoteWidget(label: 'Já possui cadastro? ', labelBold: 'Login', rota: '/auth'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        );
  }
}
