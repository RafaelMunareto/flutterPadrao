import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/login/login_module.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/auth/repositories/auth_repository.dart';
import 'package:flutter_padrao/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_hive.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flutter_padrao/app/splash/splash_page.dart';

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
    ChildRoute(Modular.initialRoute, child: (_, args) => SplashPage()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/login', module: LoginModule()),
  ];

}