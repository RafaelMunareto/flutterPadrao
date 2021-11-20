import 'package:mobx/mobx.dart';

part 'change_store.g.dart';

class ChangeStore = _ChangeStoreBase with _$ChangeStore;
abstract class _ChangeStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}