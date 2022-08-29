

class RemoteUrls {
  static const String baseUrl = "https://api.github.com/";
  static const String getList = "${baseUrl}repositories";
  static const per_page = 25;
  static String repoList(int page) => "${baseUrl}repositories?page=$page,per_page=$per_page";

  static String searchList(String query, int page, int per_page, String sort, String order) =>
      '${baseUrl}search/repositories?q=$query&page=$page&per_page=$per_page&sort=$sort&order=$order';
}
