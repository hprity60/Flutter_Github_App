import 'dart:convert';
import 'package:github_search_app/core/remote_urls.dart';
import 'package:http/http.dart' as http;

import '../../../modules/model/repository_response_model.dart';

abstract class RepoListRepository {
  Future<List<RepositoryResponseModel>> getRepoLists(int page);
}

class RepoListRepositoryIml extends RepoListRepository {
  
  @override
  Future<List<RepositoryResponseModel>> getRepoLists(int page) async {
  
    final response = await http.get(Uri.parse(RemoteUrls.repoList(page)), headers: {
      "Accept": "application/vnd.github+json",
      "Authorization": "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",
    });

    if (response.statusCode == 200) {
      //final data = json.decode(response.body);
      print(response.statusCode);
      print(response.body);
      print(response);
     final items = repositoryResponseModelFromJson(response.body);
     
      // RepositoryResponseModel items = RepositoryResponseModel.fromJson(data);
      return items;
    } else {
      print(Exception());
      throw Exception('Failed');
    }
    
  }
  
}
