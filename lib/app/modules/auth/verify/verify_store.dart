import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';

part 'verify_store.g.dart';

class VerifyStore = _VerifyStoreBase with _$VerifyStore;
abstract class _VerifyStoreBase with Store {

  AuthController auth = Modular.get();

  @observable
  String? msgEmailVerify = '';

  @action
  emailVerify()
  {
    auth.authRepository.emailVerify().then((value) {
      msgEmailVerify = value;
    }).catchError((e) => msgEmailVerify = e);
  }

}