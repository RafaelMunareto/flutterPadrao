import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_hive.dart';
import 'package:flutter_padrao/app/shared/repositories/localstorage/local_storage_interface.dart';

class ThemePreferences {
  static const String PREF_KEY = 'pref_them_key';
  final ILocalStorage _localStorage = LocalStorageHive();

  setTheme(value)
  {
    _localStorage.put(PREF_KEY, value);
  }

  getTheme(){
    _localStorage.get(PREF_KEY);
  }
}