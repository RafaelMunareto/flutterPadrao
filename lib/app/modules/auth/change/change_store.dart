import 'dart:html';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/shared/models/client_store.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';
import 'package:mobx/mobx.dart';

part 'change_store.g.dart';

class ChangeStore = _ChangeStoreBase with _$ChangeStore;
abstract class _ChangeStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();

  @observable
  bool loading = false;

  @observable
  String msgFirebase = '';

  @observable
  bool checkError = false;

  @action
  submit()
  {
    var uri = Uri.dataFromString(window.location.href);
    Map<String, String> params =
        uri.queryParameters; // query parameters automatically populated
    var code = params['oobCode'];
    loading = true;
    auth.changeResetPassword(client.password, code).then((value) {
      loading = false;
      msgFirebase = 'Senha alterada com sucesso!';
      Modular.to.navigate('/auth');
    }).catchError((e) {
      checkError = true;
      msgFirebase = ErrorPtBr().verificaCodeErro('auth/' + e.code);
    });
  }

}