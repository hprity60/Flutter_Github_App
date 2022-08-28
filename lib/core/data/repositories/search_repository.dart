import 'dart:convert';

import 'package:github_search_app/core/remote_urls.dart';
import 'package:http/http.dart' as http;

import '../../../modules/model/response_body_model.dart';

abstract class SearchRepository {
  Future<List<Item>> searchRepos(
      String query, int page, int per_page, String sort, String order);
}

class GithubRepositoryImpl extends SearchRepository {
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

