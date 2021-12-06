
abstract class IBiometricRepository {
  Future checkBiometrics();
  Future getAvailableBiometrics();
  Future<void> authenticate(String _authorized, bool _isAuthenticating);
  Future<void> authenticateWithBiometrics(String _authorized, bool _isAuthenticating);
  Future<bool> cancelAuthentication();
}
