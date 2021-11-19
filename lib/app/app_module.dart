import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/login/login_module.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/auth/repositories/auth_repository.dart';
import 'package:flutter_padrao/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_hive.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_interface.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<ILocalStorage>((i) => LocalStorageHive()),
    Bind.singleton<IAuthRepository>((i) => AuthRepository(auth: FirebaseAuth.instance)),
    Bind.singleton<AuthController>((i) => AuthController(authRepository: i.get())),

  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    WildcardRoute(
      child: (_, __) => const Scaffold(
        body: Center(child: Text('Pagina não existe')),
      ),
    )
  ];

}