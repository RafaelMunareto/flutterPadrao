import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                    "assets/img/top1.png",
                    width: size.width
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                    "assets/img/top2.png",
                    width: size.width
                ),
              ),
              Positioned(
                top: 50,
                right: 30,
                child: Image.asset(
                    "assets/img/main.png",
                    width: size.width * 0.35
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                    "assets/img/bottom1.png",
                    width: size.width
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                    "assets/img/bottom2.png",
                    width: size.width
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}