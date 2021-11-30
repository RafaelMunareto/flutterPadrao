import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/shared/models/client_store.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;
abstract class _LoginStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();

  @observable
  bool loading = false;

  @observable
  String msgErro = '';

  @action
  submit()
  {
    loading = true;
    auth.getEmailPasswordLogin(client.email, client.password).then((value) {
      loading = false;
      Modular.to.navigate('/home');
    }).catchError((e) => msgErro = ErrorPtBr().verificaCodeErro('auth/' + e.code));
  }

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