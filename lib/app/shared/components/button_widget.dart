import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonWidget extends StatefulWidget {
  final String label;
  final dynamic function;
  final bool loading;
  final double? width;

  const ButtonWidget(
      {Key? key,
      this.label = '',
      this.function,
      this.loading = false,
      this.width})
      : super(key: key);

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
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    largura = Tween<double>(begin: 400, end: widget.width ?? 500).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1)));
    altura = Tween<double>(begin: 0, end: 50).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.7)));
    radius = Tween<double>(begin: 0, end: 40).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1)));
    opacidade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.8)));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: _buildAnimation,
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return InkWell(
      child: Container(
        width: largura.value,
        height: altura.value,
        child: FadeTransition(
          opacity: opacidade,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              enabledMouseCursor: SystemMouseCursors.basic,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius.value),
              ),
            ),
            onPressed: widget.function,
            child: widget.loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    widget.label,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.value),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 255, 136, 34),
              Color.fromARGB(255, 255, 177, 41)
            ])),
      ),
    );
  }
}
