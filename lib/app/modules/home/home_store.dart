import 'package:flutter_padrao/app/modules/home/models/version_model.dart';
import 'package:flutter_padrao/app/modules/home/services/interfaces/version_service_interface.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IVersionService versionService;

  @observable
  ObservableStream<List<VersionModel>>? versionList;

  HomeStoreBase({required this.versionService}){
    getList();
  }

  @action
  void getList() {
    versionList = versionService.get().asObservable();
  }

  @action
  void save(VersionModel model) {
    versionService.save(model);
  }

  @action
  void delete(VersionModel model) {
    versionService.delete(model);
  }

}