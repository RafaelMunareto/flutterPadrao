import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_padrao/app/modules/home/repositories/interfaces/version_interfaces.dart';
import 'package:flutter_padrao/app/modules/home/repositories/version_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/home/services/interfaces/version_service_interface.dart';
import 'package:flutter_padrao/app/modules/home/services/version_service.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<IVersionService>((i) => VersionService(versionRepository: i.get())),
    Bind.singleton<IVersionRepository>((i) => VersionRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => HomeStore(versionService: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
