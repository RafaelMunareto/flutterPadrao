import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/shared/models/client_store.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  AuthController auth = Modular.get();
  ClientStore client = Modular.get();
  ILocalStorage storage = Modular.get();
  final LocalAuthentication bio = Modular.get();

  @observable
  SupportState supportState = SupportState.unknown;

  @observable
  bool loading = false;

  @observable
  String msg = '';

  @observable
  bool faceOrFinger = true;

  @observable
  bool errOrGoal = false;

  @observable
  List<String>? loginStorage;

  @action
  setErrOrGoal(value) => errOrGoal = value;

  @action
  setMsg(value) => msg = value;

  @action
  setLoading(value) => loading = value;

  //biometric
  @observable
  bool canCheckBiometrics = false;

  @observable
  List<BiometricType> availableBiometrics = [];

  @observable
  String authorized = 'Não autorizado!';

  @observable
  bool isAuthenticating = false;

  authenticate(email, password)
  {
    setLoading(true);
    auth.getEmailPasswordLogin(email, password).then((value) {
      if (value.user.emailVerified) {
        Modular.to.navigate('/home');
      }
      setLoading(false);
      setErrOrGoal(false);
      setMsg('Você deve validar o email primeiro!');
    }).catchError((e) {
      setLoading(false);
      setErrOrGoal(false);
      setMsg(ErrorPtBr().verificaCodeErro('auth/' + e.code));
    });
  }

  @action
  submit() async {
    setLoading(true);
    auth.getEmailPasswordLogin(client.email, client.password).then((value) {
      if (value.user.emailVerified) {
        setStorageLogin();
        Modular.to.navigate('/home');
      }
      setLoading(false);
      setErrOrGoal(false);
      setMsg('Você deve validar o email primeiro!');
    }).catchError((e) {
      setLoading(false);
      setErrOrGoal(false);
      setMsg(ErrorPtBr().verificaCodeErro('auth/' + e.code));
    });
  }

  @action
  loginWithGoogle() async {
    try {
      loading = true;
      await auth.loginWithGoogle();
      Modular.to.navigate('/home');
    } catch (e) {
      loading = false;
    }
  }

  //biometric
  @action
  checkBiometrics() {
    auth.biometricRepository
        .checkBiometrics()
        .then((value) => canCheckBiometrics = value);
  }

  @action
  getAvailableBiometrics() async {
    await auth.biometricRepository
        .getAvailableBiometrics()
        .then((value) => availableBiometrics = value);
    if (availableBiometrics.contains(BiometricType.face)) {
      faceOrFinger = true;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      faceOrFinger = false;
    }
  }

  @action
  authenticateWithBiometrics() async {
    if (canCheckBiometrics) {
      bool authenticated = false;
      try {
        isAuthenticating = true;
        authorized = 'Autenticado';
        authenticated = await bio.authenticate(
            localizedReason:
                faceOrFinger ? 'Aponte para seu rosto' : 'Coloque sua digital',
            useErrorDialogs: true,
            androidAuthStrings: const AndroidAuthMessages(
              cancelButton: 'Cancelar',
              signInTitle: 'Requer autenticação',
              biometricHint: 'Verifica identidade',
            ),
            stickyAuth: true,
            biometricOnly: true);
        isAuthenticating = false;
        authorized = 'Autenticando';
      } on PlatformException catch (e) {
        //print(e);
        isAuthenticating = false;
        authorized = "Error - ${e.message}";
        return;
      }
      final String message = authenticated ? 'Authorized' : 'Not Authorized';
      authorized = message;
    }

    if(authorized == 'Authorized'){
       authenticate(loginStorage![0], loginStorage![1]);
    }
  }

  @computed
  get login {
    List<String> login = [client.email, client.password];
    return login;
  }

  //storage save login e password
  void setStorageLogin() async {
    await storage.put('biometric', login);
  }

  @action
  getStorageLogin() async {
    await storage.get('biometric').then((value) => loginStorage = value);
  }

  //check support device
  @action
  checkSupportDevice() async {
    await getStorageLogin();
    await bio.isDeviceSupported().then((isSupported) => supportState =
        isSupported && loginStorage != null
            ? SupportState.supported
            : SupportState.unsupported);
    await checkBiometrics();
    await getAvailableBiometrics();
  }
}

enum SupportState {
  unknown,
  supported,
  unsupported,
}
