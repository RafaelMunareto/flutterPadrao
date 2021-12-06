import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/auth/repositories/biometric_repository_interface.dart';
import 'package:local_auth/local_auth.dart';

class BiometricRepository implements IBiometricRepository {
  final LocalAuthentication auth = Modular.get();

  @override
  Future<void> authenticate(String _authorized, bool _isAuthenticating) async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
        _isAuthenticating = false;
    } on PlatformException catch (e) {
      _isAuthenticating = false;
      _authorized = "Error - ${e.message}";
      return;
    }
    _authorized = authenticated ? 'Authorized' : 'Not Authorized';
  }

  @override
  Future<void> authenticateWithBiometrics(String _authorized, bool _isAuthenticating) async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';
      authenticated = await auth.authenticate(
          localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
        _isAuthenticating = false;
        _authorized = 'Authenticating';
    } on PlatformException catch (e) {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      return;
    }
    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    _authorized = message;
  }

  @override
  Future<bool> cancelAuthentication() async {
    await auth.stopAuthentication();
    return false;
  }

  @override
  Future checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      return e;
    }
      return canCheckBiometrics;
  }

  @override
  Future getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
     return e;
    }
      return availableBiometrics;
  }

}