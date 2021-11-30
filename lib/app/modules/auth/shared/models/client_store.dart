import 'package:mobx/mobx.dart';

part 'client_store.g.dart';

class ClientStore = _ClientStoreBase with _$ClientStore;
abstract class _ClientStoreBase with Store {

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @action
  changeName(String value) => name = value;

  @action
  changeEmail(String value) => email = value;

  @action
  changePassword(String value) => password = value;

  @action
  changeConfirmPassword(String value) => confirmPassword = value;


  @computed
  bool get isValidLogin {
    return
          validateEmail() == null
          && validatePassword() == null;
  }

  String? validateName(){
    if (name.isEmpty) {
      return 'Campo obrigatório';
    } else if (name.length < 3) {
      return 'Necessário ser maior que 3 caracteres';
    }
    return null;
  }

  String? validateEmail(){
    if (email.isEmpty) {
      return 'Campo obrigatório';
    } else if (!email.contains('@')) {
      return 'Email inválido';
    }
    return null;
  }

  String? validatePassword(){
    if (password.isEmpty) {
      return 'Campo obrigatório';
    } else if (password.length < 6) {
      return 'Necessário ser maior que 3 caracteres';
    }
    return null;
  }

  String? validateConfirmPassword(){
    if (password != confirmPassword) {
      return 'As senhas devem ser iguais.';
    } else if (confirmPassword.isEmpty) {
      return 'Campo obrigatório';
    } else if (confirmPassword.length < 6) {
      return 'Necessário ser maior que 3 caracteres';
    }
    return null;
  }


}