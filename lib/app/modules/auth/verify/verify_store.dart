import 'package:mobx/mobx.dart';

part 'verify_store.g.dart';

class VerifyStore = _VerifyStoreBase with _$VerifyStore;
abstract class _VerifyStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}