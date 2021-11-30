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
  String msgErro = '';

  @action
  submit()
  {
    loading = true;
    auth.changeResetPassword(client.password).then((value) {
      loading = false;
      Modular.to.navigate('/auth');
    }).catchError((e) => msgErro = ErrorPtBr().verificaCodeErro('auth/' + e.code));
  }

}