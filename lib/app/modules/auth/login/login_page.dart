import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/login/login_store.dart';
import 'package:flutter/material.dart';

import '../../../app_widget.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Choose your theme:',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// //////////////////////////////////////////////////////
                /// Change theme & rebuild to show it using these buttons
                ElevatedButton(
                    onPressed: () => AppWidget.of(context)!.changeTheme(ThemeMode.light),
                    child: Text('Light')),
                ElevatedButton(
                    onPressed: () => AppWidget.of(context)!.changeTheme(ThemeMode.dark),
                    child: Text('Dark')),
                /// //////////////////////////////////////////////////////
              ],
            ),
          ],
        ),
      ),
    );
  }
}