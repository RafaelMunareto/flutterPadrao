import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/components/background_widget.dart';
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
        if (store.msg != '') {
          SnackbarCustom().createSnackBareErrOrGoal(_scaffoldKey,
              message: store.msg, errOrGoal: store.errOrGoal);
          store.setMsg('');
        }
      },
    );
  }

  @override
  void initState() {
    store.checkSupportDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: BackgroundWidget(
        child: LayoutBuilder(builder: (context, constraint) {
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
              child: SizedBox(
            width: largura,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(
                    child: TextFieldWidget(
                        labelText: 'E-mail',
                        onChanged: store.client.changeEmail,
                        errorText: store.client.validateEmail)),
                SizedBox(
                  child: TextFieldWidget(
                      labelText: 'Senha',
                      obscure: true,
                      onChanged: store.client.changePassword,
                      errorText: store.client.validatePassword),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: const LinkRoteWidget(
                      labelBold: 'Esqueceu a senha ? ', rota: '/auth/forget'),
                ),
                SizedBox(height: size.height * 0.05),
                Observer(builder: (_) {
                  return Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ButtonWidget(
                        label: 'LOGIN',
                        width: size.width * 0.5,
                        loading: store.loading,
                        function:
                            store.client.isValidLogin ? store.submit : null),
                  );
                }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 58),
                  child: const LinkRoteWidget(
                      labelBold: 'Não tem cadastro? Registre-se',
                      rota: '/auth/signup'),
                ),
                Observer(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 32, right: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40),
                          child: GestureDetector(
                            child: const Image(
                              image: AssetImage('assets/img/google.png'),
                            ),
                            onTap: store.loginWithGoogle,
                          ),
                        ),
                        store.supportState == SupportState.supported
                            ? GestureDetector(
                          onTap: store.authenticateBiometric,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20),
                            width: 64,
                            child: store.faceOrFinger
                                ? const Image(
                                image:
                                AssetImage('assets/img/face.png'))
                                : const Image(
                                image: AssetImage(
                                    'assets/img/digital.png')),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
          ));
        }),
      ),
    );
  }
// @override
// Widget build(BuildContext context) {
//   var altura = MediaQuery.of(context).size.height * 0.2;
//   return Scaffold(
//     key: _scaffoldKey,
//     appBar: AppBarWidget(
//         title: widget.title, size: altura, context: context, back: false),
//     body: LayoutBuilder(builder: (context, constraint) {
//       var largura = constraint.maxWidth;
//
//       if (largura < 600) {
//         largura = largura * 1;
//       } else if (largura < 768) {
//         largura = largura * 0.6;
//       } else if (largura < 1024) {
//         largura = largura * 0.4;
//       } else {
//         largura = largura * 0.2;
//       }
//
//       return SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: SizedBox(
//               width: largura,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   TextFieldWidget(
//                       labelText: 'E-mail',
//                       onChanged: store.client.changeEmail,
//                       errorText: store.client.validateEmail),
//                   TextFieldWidget(
//                       labelText: 'Senha',
//                       obscure: true,
//                       onChanged: store.client.changePassword,
//                       errorText: store.client.validatePassword),
//                   Observer(builder: (_) {
//                     return ButtonWidget(
//                         label: 'LOGIN',
//                         loading: store.loading,
//                         function:
//                             store.client.isValidLogin ? store.submit : null);
//                   }),
//                   Observer(builder: (_) {
//                     return ButtonWidget(
//                         label: 'GOOGLE',
//                         loading: store.loadingGoogle,
//                         function:store.loginWithGoogle
//                     );
//                   }),
//
//                   const LinkRoteWidget(
//                       labelBold: 'Esqueceu a senha', rota: '/auth/forget'),
//                   const LinkRoteWidget(
//                       label: 'Não possui cadastro? ',
//                       labelBold: 'Registre-se',
//                       rota: '/auth/signup'),
//                   Observer(builder: (_) {
//                     return Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: store.supportState == SupportState.supported
//                             ? GestureDetector(
//                                 onTap: store.authenticateBiometric,
//                                 child: SizedBox(
//                                   width: 92,
//                                   child: store.faceOrFinger
//                                       ? const Image(
//                                           image: AssetImage(
//                                               'assets/img/face.png'))
//                                       : const Image(
//                                           image: AssetImage(
//                                               'assets/img/digital.png')),
//                                 ),
//                               )
//                             : Container());
//                   })
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }),
//   );
// }
}
