import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final onChanged;
  final bool obscure;
  final Function() errorText;

  const TextFieldWidget(
      {Key? key,
      required this.labelText,
      required this.onChanged,
      this.obscure = false,
      required this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return TextField(
        onChanged: onChanged,
        obscureText: obscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          errorText: errorText == null ? null : errorText(),
        ),
      );
    });
  }
}
