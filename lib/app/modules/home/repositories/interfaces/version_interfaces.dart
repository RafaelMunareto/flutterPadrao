
import 'package:flutter_padrao/app/modules/home/models/version_model.dart';

abstract class IVersionRepository {
  Stream<List<VersionModel>> get();
  Future save(VersionModel model);
  Future delete(VersionModel model);
  Future<Stream<VersionModel>> getByDocumentId(String documentId);

}