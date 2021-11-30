import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';
import 'package:flutter_padrao/app/shared/components/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title, size: altura, context: context, back: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      Modular.to.navigate('/home');
                    },
                    child: const Text('home')),
              ),
              TextFieldWidget(
                  labelText: 'email',
                  onChanged: store.client.changeEmail,
                  errorText: store.client.validateEmail),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  labelText: 'Password',
                  obscure: true,
                  onChanged: store.client.changePassword,
                  errorText: store.client.validatePassword),
              Observer(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8,24,8,24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    onPressed: store.client.isValidLogin ? store.submit : null,
                    child: Text('CADASTRAR'),
                  ),
                );
              }),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não possui cadastro?  ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () { Modular.to.navigate('/auth/signup');},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
