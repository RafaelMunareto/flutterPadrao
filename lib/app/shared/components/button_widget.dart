import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ButtonWidget extends StatefulWidget {
  final String label;
  final function;

  ButtonWidget({this.label = '', this.function});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> largura;
  late Animation<double> altura;
  late Animation<double> opacidade;
  late Animation<double> radius;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    largura = Tween<double>(begin: 0, end: 500).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1)));
    altura = Tween<double>(begin: 0, end: 50).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.7)));
    radius = Tween<double>(begin: 0, end: 20).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1)));
    opacidade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)));

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedBuilder(
          animation: this._controller,
          builder: _buildAnimation,
        ),
      );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
          width: largura.value,
          height: altura.value,
          child: FadeTransition(
            opacity: opacidade,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius.value),
                      )
                  )
              ),
              onPressed: widget.function,
              child: Text(widget.label),
            ),
          ),
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(radius.value),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(255, 176, 176, 1),
                Color.fromRGBO(191, 43, 26, 1),
              ])),
        ),
      ),
    );
  }
}
