import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/models/repository_response_model.dart';

abstract class LocalDataSource {
  Future<bool> cacheListsResponse(
      RepositoryResponseModel repositoryResponseModel);
  List<RepositoryResponseModel> getRepoResponseModel();
  Future<bool> clearList();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  List<RepositoryResponseModel> getRepoResponseModel() {
    final jsonString = sharedPreferences.getString('cachedListResponseKey');
    if (jsonString != null) {
      return repositoryResponseModelFromJson(jsonString);
    } else {
      throw Exception('Not cached yet');
    }
  }

  @override
  Future<bool> cacheListsResponse(
      RepositoryResponseModel repositoryResponseModel) {
    return sharedPreferences.setString(
        'cachedListResponseKey', jsonEncode(repositoryResponseModel));
  }

  @override
  Future<bool> clearList() {
    return sharedPreferences.remove('cachedListResponseKey');
  }
}

// import 'package:github_search_app/modules/search/model/repository_response_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import '../../../modules/search/model/response_body_model.dart';

// abstract class LocalDataRepository {
//   Future<Box> openBox();
//   List<RepositoryResponseModel> getRepo(Box box);
//   Future<void> searchRepoList(Box box,int index, List<Item> item);
//   Future<void> removeSearchRepoList(Box box,int index, List<Item> item);
//   Future<void> clearRepoList(Box box);
// }

// class LocalDataRepositoryIml extends LocalDataRepository {
//   String boxName = 'repolist';

//   @override
//   List<RepositoryResponseModel> getRepo(Box box) {
//     return box.values.toList() as List<RepositoryResponseModel>;
//   }

//   @override
//   Future<Box> openBox() async {
//     Box box = await Hive.openBox<RepositoryResponseModel>(boxName);
//     return box;
//   }

//   @override
//   Future<void> searchRepoList(Box box, int index, List<Item> item) async {
//     await box.put(item[index].id, item);
//   }

//   @override
//   Future<void> removeSearchRepoList(Box box,int index, List<Item> item) async {
//     await box.delete(item[index].id);
//   }

//   @override
//   Future<void> clearRepoList(Box box) async {
//     await box.clear();
//   }
// }
