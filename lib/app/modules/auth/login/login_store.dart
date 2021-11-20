import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;
abstract class _LoginStoreBase with Store {
  AuthController auth;

  @observable
  bool loading = false;

  _LoginStoreBase({required this.auth});

  @action
  loginWithGoogle() async {
    try {
      loading = true;

      await auth.loginWithGoogle();
      Modular.to.navigate('/home');
    } catch (e) {
      loading = false;
    }
  }
}