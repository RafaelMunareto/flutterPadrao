//import 'dart:html';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/shared/models/client_store.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';
import 'package:mobx/mobx.dart';

part 'forget_store.g.dart';

class ForgetStore = _ForgetStoreBase with _$ForgetStore;
abstract class _ForgetStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();

  @observable
  bool loading = false;

  @observable
  bool checkError = false;

  @observable
  String msg = '';

  @action
  setMsg(value) => msg = value;

  @action
  setLoading(value) => loading = value;

  @observable
  bool msgErrOrGoal = false;

  @action
  setMsgErrOrGoal(value) => msgErrOrGoal = value;

  @action
  submit()
  {
    setLoading(true);
    auth.sendChangePasswordEmail(client.email).then((value) async {
       setLoading(false);
       setMsgErrOrGoal(true);
       setMsg('Senha enviada com sucesso!');
    }).catchError((e) {
      setLoading(false);
      setMsgErrOrGoal(false);
      setMsg(ErrorPtBr().verificaCodeErro('auth/' + e.code));
    });
  }

}