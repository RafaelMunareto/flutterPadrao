import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final type;
  final bool obscureText;
  final bool autofocus;
  final icon;
  final controller;
  final validator;
  final submit;
  final name;
  InputWidget(
      {this.label = '',
        this.type,
        this.name,
        this.obscureText = false,
        this.autofocus = false,
        this.validator,
        this.submit = false,
        this.icon,
        this.controller});

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: TextFormField(
        controller: widget.controller,
        autofocus: widget.autofocus,
        keyboardType: widget.type,
        obscureText: widget.obscureText,
        autovalidateMode: widget.submit
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        style: const TextStyle(fontSize: 16),
        validator: widget.validator,
        onChanged: widget.name,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: Colors.grey),
          contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          labelText: widget.label,
          filled: true,
          fillColor: const Color(0xffefeef2),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(25.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(25.0),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Color(0xffefeef2), width: 0),
          ),
        ),
      ),
    );
  }
}