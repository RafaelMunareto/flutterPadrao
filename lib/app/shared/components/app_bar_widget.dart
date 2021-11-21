import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double size;
  final context;
  final controller;
  final bool settings;
  final bool back;
  final String rota;

  AppBarWidget(
      {Key? key,
      this.title = "AppBarWidget",
      this.size = 200,
      this.context,
      this.controller,
      this.settings = false,
      this.back = true,
      this.rota = '/auth'})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(size);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size),
      child: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(150, 50),
          ),
        ),
        actions: [
          settings
              ? IconButton(
                  onPressed: () {
                    Modular.to.navigate('/settings');
                  },
                  icon: const Icon(Icons.more_vert),
                )
              : Container()
        ],
        title: Text(title),
        leading: back
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Modular.to.navigate(rota))
            : Container(),
      ),
    );
  }
}
