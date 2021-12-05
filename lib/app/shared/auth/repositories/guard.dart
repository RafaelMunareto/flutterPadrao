
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    return Modular.get<AuthController>().usuarioNaoLogado();
  }
}