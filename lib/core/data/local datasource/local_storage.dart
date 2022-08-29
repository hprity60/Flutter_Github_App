import 'package:hive/hive.dart';

import '../../../modules/models/repository_response_model.dart';
import '../../../modules/models/response_body_model.dart';

abstract class LocalStorage {
  Future<Box> openBox();
  List<Item> getRepoList(Box box);
  Future<void> searchList(Box box, Item item);
  Future<void> removeList(Box box, Item item);
  Future<void> clearList(Box box);
}

class LocalStorageIml implements LocalStorage {
  String boxName = 'repolist_data';
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<RepositoryResponseModel>(boxName);
    return box;
  }

  @override
  List<Item> getRepoList(Box box) {
    return box.values.toList() as List<Item>;
  }

  @override
  Future<void> searchList(Box box, Item item) async {
    await box.put(item.id, item);
  }

  @override
  Future<void> removeList(Box box, Item item) async {
    await box.delete(item.id);
  }

  @override
  Future<void> clearList(Box box) async {
    await box.clear();
  }
}
