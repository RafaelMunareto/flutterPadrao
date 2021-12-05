import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/shared/models/client_store.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';
import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStoreBase with _$SignupStore;

abstract class _SignupStoreBase with Store {
  ClientStore client = Modular.get();
  FirebaseFirestore db = Modular.get();
  AuthController auth = Modular.get();

  @observable
  List grupoEmail = [];

  @observable
  bool loading = false;

  @observable
  bool? checkGrupoEmail;

  @observable
  String msg = '';

  @observable
  bool msgErrOrGoal = false;

  @action
  setMsgErrOrGoal(value) => msgErrOrGoal = value;

  @action
  setLoading(value) => loading = value;

  @action
  setMsg(value) => msg = value;

  @action
  setCheckGrupoEmail(value) => checkGrupoEmail = value;

  @action
  changeEmailGrupo(String value) => client.email = value;

  @action
  setGrupoEmail() {
    auth.authRepository.getGrupoEmail().then((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        grupoEmail.add(doc["grupo"]);
      }
    });
  }

  @computed
  bool get isValidRegisterEmailGrupo {
    return client.validateName() == null &&
        validateEmailGrupo() == null &&
        client.validatePassword() == null &&
        client.validateConfirmPassword() == null;
  }

  @action
  void submit() {
    if (!grupoEmail.contains(client.email.split('@')[1])) {
      setCheckGrupoEmail(true);
    } else {
      setLoading(true);
      auth
          .createUserLinkEmail(client.name, client.email, client.password)
          .then((value) {
        setCheckGrupoEmail(false);
        setMsgErrOrGoal(true);
        setMsg('E-mail enviado com sucesso!');
        setLoading(false);
      }).catchError((e) {
        setCheckGrupoEmail(true);
        setMsgErrOrGoal(false);
        setLoading(false);
        setMsg(ErrorPtBr().verificaCodeErro('auth/' + e.code));
      });
    }
  }

  String? validateEmailGrupo() {
    if (client.email.isEmpty) {
      return 'Campo obrigatório';
    } else if (!client.email.contains('@')) {
      return 'Email inválido';
    } else if (!grupoEmail.contains(client.email.split('@')[1])) {
      return 'Grupo de Email inválido';
    }
    return null;
  }
}
