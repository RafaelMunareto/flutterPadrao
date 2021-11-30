


abstract class IAuthRepository {
  getUser();
  getGoogleLogin();
  Future getFacebookLogin();
  Future getEmailPasswordLogin();
  Future<String> getToken();
  Future getLogout();
  Future createUserSendEmailLink(name, email, password);
  Future createUserEmailPassword(name, email, password);
  Future getGrupoEmail();
  Future<String?> emailVerify();

}
