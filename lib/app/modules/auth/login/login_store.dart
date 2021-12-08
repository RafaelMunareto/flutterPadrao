import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/shared/models/client_store.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';
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

  //gooole
  @action
  loginWithGoogle() async {

    try {
      await setLoading(true);
      await auth.loginWithGoogle();
      Modular.to.navigate('/home');
    } catch (e) {
      setLoading(false);
      setErrOrGoal(false);
      setMsg(e.toString());
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
  authenticateBiometric()
  {
    auth.authenticateWithBiometrics(faceOrFinger).then((value) {
      if(value == 'Authorized'){
        setLoading(true);
        auth.getEmailPasswordLogin(loginStorage![0], loginStorage![1]).then((value) {
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
    });
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

  @action
  submitStorage()
  {
    storage.get('biometric').then((value)  {
        if(!value.isEmpty) {
          auth.getEmailPasswordLogin(value[0], value[1]).then((value) {
            setLoading(false);
            setErrOrGoal(false);
            setMsg('Você deve validar o email primeiro!');
            Modular.to.navigate('/home');
          }).catchError((e) {
            setLoading(false);
            setErrOrGoal(false);
            setMsg(ErrorPtBr().verificaCodeErro('auth/' + e.code));
          });
        }

    });
  }
}

enum SupportState {
  unknown,
  supported,
  unsupported,
}
