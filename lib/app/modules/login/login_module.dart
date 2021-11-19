import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/login/login_page.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';

import 'login_store.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore(auth: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child:  (context, args) => LoginPage()),
  ];
}