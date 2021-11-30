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
  String msgErro = '';

  @action
  submit()
  {
    loading = true;
    auth.sendChangePasswordEmail(client.email).then((value) {
      loading = false;
      Modular.to.navigate('/auth');
    }).catchError((e) => msgErro = ErrorPtBr().verificaCodeErro('auth/' + e.code));
  }

}