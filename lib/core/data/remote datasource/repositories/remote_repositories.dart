import 'dart:convert';
import 'package:github_search_app/core/remote_urls.dart';
import 'package:http/http.dart' as http;

import '../../../../modules/models/repository_response_model.dart';
import '../../../../modules/models/response_body_model.dart';



abstract class ApiRepositories {
  Future<List<RepositoryResponseModel>> getRepoLists(int page);
  Future<List<Item>> searchRepos(
      String query, int page, int per_page, String sort, String order);
}

class ApiRepositoriesIml extends ApiRepositories {
  
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
  
  @override
  Future<List<Item>> searchRepos(String query, int page, int per_page,
      String sort, String order) async {
    
    var response = await http.get(
        Uri.parse(RemoteUrls.searchList(query, page, per_page, sort, order)),
        headers: {
          "Accept": "application/vnd.github+json",
          //"Authorization": "Berear $token",
        });
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      print(response);
      var data = json.decode(response.body);

      List<Item>? items = ResponseBodyModel.fromJson(data).items!;
      return items;
    } else {
      print(Exception());
      throw Exception('Failed');
    }
  }
}
