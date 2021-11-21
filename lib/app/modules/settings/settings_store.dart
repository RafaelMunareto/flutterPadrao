import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/auth/auth_controller.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flutter_padrao/app/shared/utils/themes/theme_model.dart';
import 'package:flutter_padrao/app/shared/utils/themes/theme_preferences.dart';
import 'package:mobx/mobx.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStoreBase with _$SettingsStore;
abstract class _SettingsStoreBase with Store {
  final ILocalStorage storage = Modular.get();

  @observable
  bool isSwitched = false;

  @action
  buscaTheme()
  {
    this.storage.get('theme').then((value) {
      if(value[0] == 'dark'){
        this.isSwitched = true;
      }else{
        this.isSwitched = false;
      }
    });
  }

  @action
  changeSwitch(value)
  {
    List<String> data = [];
    this.isSwitched = value;
    this.isSwitched ? data = ['dark'] : data = ['light'];
    this.storage.put('theme', data);
  }

  logoff() async {
    await Modular.get<AuthController>().logout();
    Modular.to.navigate('/auth');
  }


}