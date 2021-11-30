import 'dart:html';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'verify_store.g.dart';

class VerifyStore = _VerifyStoreBase with _$VerifyStore;
abstract class _VerifyStoreBase with Store {

  AuthController auth = Modular.get();

  @observable
  String msgEmailVerify = '';

  @observable
  String tipo = '';

  @action
  verificaTipo()
  {
    var uri = Uri.dataFromString(window.location.href);
    Map<String, String> params =
        uri.queryParameters; // query parameters automatically populated
    var actionCode = params['mode'];
    if (actionCode != null) {
      tipo = actionCode;
    }
  }

  @action
  emailVerify()
  {
    if(tipo == 'verifyEmail')
      auth.authRepository.emailVerify().then((value) {
        msgEmailVerify = value ?? 'Código inválido.';
      });
  }


}