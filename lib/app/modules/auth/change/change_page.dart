import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/change/change_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/app_bar_widget.dart';
import 'package:flutter_padrao/app/shared/components/text_field_widget.dart';
import 'package:flutter_padrao/app/shared/utils/snackbar_custom.dart';
import 'package:mobx/mobx.dart';

class ChangePage extends StatefulWidget {
  const ChangePage({Key? key}) : super(key: key);
  @override
  ChangePageState createState() => ChangePageState();
}
class ChangePageState extends State<ChangePage> {
  final ChangeStore store = Modular.get();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autorun((_) {
      if (store.checkError) {
        if (store.msgFirebase != '') {
          SnackbarCustom()
              .createSnackBar(store.msgFirebase, Colors.red, context);
        }
      } else {
        if (store.msgFirebase != '') {
          SnackbarCustom()
              .createSnackBar(store.msgFirebase, Colors.green, context);
        }
      }

      print(store.client.isValidChangePassword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        labelText: 'Password',
                        obscure: true,
                        onChanged: store.client.changePassword,
                        errorText: store.client.validatePassword),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        labelText: 'confirmPassword',
                        obscure: true,
                        onChanged: store.client.changeConfirmPassword,
                        errorText: store.client.validateConfirmPassword),
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
                          store.client.isValidChangePassword ? store.submit : null,
                          child: store.loading ? CircularProgressIndicator(color: Colors.white,) : Text('ALTERAR'),
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
