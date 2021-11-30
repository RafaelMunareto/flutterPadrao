import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/signup/signup_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';
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
        if(store.msgFirebase != '') {
          SnackbarCustom()
              .createSnackBar(store.msgFirebase, Colors.red, context);
        }
      }else{
        if(store.msgFirebase != '') {
          SnackbarCustom()
              .createSnackBar(store.msgFirebase, Colors.green, context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(title: widget.title, size: altura, context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            verticalDirection: VerticalDirection.down,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                child: Center(
                  child: Text(
                    'Registre-se',
                    style: TextStyle(
                      fontSize: 32.0,
                    ),
                  ),
                ),
              ),
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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    onPressed:
                        store.isValidRegisterEmailGrupo ? store.submit : null,
                    child: store.loading ? CircularProgressIndicator(color: Colors.white) : Text('CADASTRAR'),
                  ),
                );
              }),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já possui cadastro. ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Modular.to.navigate('/auth');
                      },
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
