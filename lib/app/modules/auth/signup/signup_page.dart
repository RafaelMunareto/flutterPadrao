import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/signup/signup_store.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final String title;
  const SignupPage({Key? key, this.title = 'SignupPage'}) : super(key: key);
  @override
  SignupPageState createState() => SignupPageState();
}
class SignupPageState extends State<SignupPage> {
  final SignupStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: const <Widget>[],
      ),
    );
  }
}