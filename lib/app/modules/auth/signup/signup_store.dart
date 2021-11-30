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
  String msgFirebase = '';

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
      checkGrupoEmail = true;
    } else {
      loading = true;
      auth.authRepository
          .createUserSendEmailLink(client.name, client.email, client.password)
          .then((value) {
        checkGrupoEmail = false;
        msgFirebase = 'Email enviado com sucesso!';
        loading = false;
        Modular.to.navigate('/auth');
      }).catchError((error) {
        loading = false;
        checkGrupoEmail = true;
        msgFirebase = ErrorPtBr().verificaCodeErro('auth/' + error.code);
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
