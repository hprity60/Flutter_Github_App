import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/modules/model/response_body_model.dart';
import '../../../utils/utility.dart';
import '../controllers/search bloc/search_bloc.dart';

class GithubRepoSearch extends SearchDelegate<List> {
  SearchBloc searchBloc;

  int page = 1;

  int perPage = 40;

  String sort = 'stars';
  String order = 'dsce';

  GithubRepoSearch({
    required this.searchBloc,
    required this.page,
    required this.perPage,
    required this.sort,
    required this.order,
  });
  late String queryString;
  //final dateFormatter = DateFormat('MMMM dd h:mm a');
  //final dateString = dateFormatter.format(item!.date);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, []);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //SearchBloc searchBloc;

    int page = 1;

    int perPage = 40;

    String sort = 'stars';
    String order = 'dsce';
    queryString = query;

    searchBloc.add(SearchEventSearch(query, sort, page, perPage, order));
    List<Item> item = [];
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchStateLoading) {
          return buildLeading(context);
        }
        if (state is SearchStateError) {
          return Text(state.message);
        }
        if (state is SearchStateLoaded) {
          if (state.items!.isEmpty) {
            return const Center(
              child: Text('No Results'),
            );
          }
          return
              //buildSearchList(state.items!);

              Column(
            children: [
              TextButton(
                onPressed: () {
                  searchBloc.add(SearchEventSearch(
                    query,
                    'asce',
                    50,
                    60,
                    'forks',
                  ));
                },
                child: Text('Sort by star'),
              ),
              TextButton(
                onPressed: () {
                  searchBloc.add(
                      SearchEventSearch(query, sort, perPage, page, order));
                },
                child: Text('Sort by updated'),
              ),
              Flexible(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.blue,
                        height: 15,
                      );
                    },
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: InkWell(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //RepoDetailPage(items: state.items[index])
                            //));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.items![index].fullName!),
                              Text(Utility.toformattedDate2(
                                  state.items![index].createdAt!)),
                              // Image.network(
                              //   state.items![index].createdAt,
                              //   height: 50,
                              //   width: 50,
                              // ),
                              Text(
                                  "${state.items![index].stargazersCount} Starts"),
                              SizedBox(height: 16),
                              Text(
                                "${state.items![index].forksCount!} Forks",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(height: 4),

                              SizedBox(height: 16),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Icon(Icons.star,
                                    size: 20, color: Colors.yellowAccent[700]),
                              ),
                              SizedBox(width: 10),
                              // Text(
                              //   "${items[index].st
                              //   stargazers.totalCount}",
                              //   style: Theme.of(context).textTheme.subtitle2,
                              // ),
                              SizedBox(width: 20),
                              const Icon(
                                Icons.blur_circular,
                                color: Colors.yellow,
                                //items[index].
                                //languages.nodes.first.color,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${state.items![index].description}",
                                //.languages.nodes.first.name}",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.items!.length),
              ),
            ],
          );
        }
        return const Scaffold();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
