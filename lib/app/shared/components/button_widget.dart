import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_padrao/app/modules/auth/signup/signup_store.dart';

class ButtonWidget extends StatefulWidget {
  final String label;

  ButtonWidget({this.label = ''});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {

  final storage = SignupStore();
  @override
  Widget build(BuildContext context) {

    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          onPressed: storage.isValidRegisterEmailGrupo ? storage.submit : null,
          child: Text(widget.label),
        ),
      );
    });
  }
}
