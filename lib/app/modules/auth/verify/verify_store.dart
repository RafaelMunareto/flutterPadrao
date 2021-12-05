import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';
import 'package:mobx/mobx.dart';

part 'verify_store.g.dart';

class VerifyStore = _VerifyStoreBase with _$VerifyStore;
abstract class _VerifyStoreBase with Store {

  AuthController auth = Modular.get();

  @observable
  String code = '';

  @observable
  String msg = '';

  @observable
  bool msgErrOrGoal = false;

  @action
  setCode(value) => code = value;

  @action
  setMsgErrOrGoal(value) => msgErrOrGoal = value;

  @action
  setMsg(value) => msg = value;

  @action
  emailVerify()
  {
      auth.authRepository.emailVerify(code).then((value) {
        setMsgErrOrGoal(true);
        setMsg('Código validado!');
        Timer(const Duration(seconds: 2), () => Modular.to.navigate('/auth'));
      }).catchError((e) {
        setMsgErrOrGoal(false);
        setMsg(ErrorPtBr().verificaCodeErro('auth/' + e.code));
      });

  }


}