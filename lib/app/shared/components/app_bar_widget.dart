import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double size;
  final context;
  final controller;

  AppBarWidget({Key? key, this.title = "AppBarWidget", this.size=200, this.context, this.controller}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(size);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text(title),
      actions: [
        IconButton(onPressed:() { Modular.to.navigate('/settings'); }, icon: const Icon(Icons.more_vert))
      ],
    );
  }


}
