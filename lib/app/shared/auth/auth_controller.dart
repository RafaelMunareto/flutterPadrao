import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_padrao/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:mobx/mobx.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository authRepository;

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  User? user;

  _AuthControllerBase({required this.authRepository}){
   setUser(authRepository.getUser());
  }

  @action
  setUser(User? value) {
    user = value;
    status = user == null ? AuthStatus.logoff : AuthStatus.login;
  }

  @action
  Future loginWithGoogle() async {
    user = await authRepository.getGoogleLogin();
  }

  Future logout() {
    return authRepository.getLogout();
  }
}

enum AuthStatus { loading, login, logoff }
