import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/auth_module.dart';
import 'package:flutter_padrao/app/modules/settings/settings_module.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/auth/repositories/auth_repository.dart';
import 'package:flutter_padrao/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_share.dart';
import 'package:flutter_padrao/app/shared/utils/themes/theme_preferences.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<ILocalStorage>((i) => LocalStorageShare()),
    Bind.singleton<ThemePreferences>((i) => ThemePreferences()),
    Bind.singleton<IAuthRepository>((i) => AuthRepository(auth: FirebaseAuth.instance)),
    Bind.singleton<AuthController>((i) => AuthController(authRepository: i.get())),

  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/auth', module: AuthModule(), transition: TransitionType.leftToRightWithFade),
    ModuleRoute('/home', module: HomeModule(), transition: TransitionType.leftToRightWithFade),
    ModuleRoute('/settings', module: SettingsModule(), transition: TransitionType.leftToRightWithFade),
    WildcardRoute(
      child: (_, __) => const Scaffold(
        body: Center(child: Text('Pagina não existe')),
      ),
    )
  ];

}