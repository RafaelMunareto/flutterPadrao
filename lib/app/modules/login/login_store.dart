import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginBase with _$LoginStore;

abstract class _LoginBase with Store {
  AuthController auth;

  @observable
  bool loading = false;

  _LoginBase({required this.auth});

  @action
   loginWithGoogle() async {
    print('ok');
    try {
      loading = true;

      await auth.loginWithGoogle();
      Modular.to.navigate('/home');
    } catch (e) {
      loading = false;
    }
  }
}
