import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/repo cubit/repo_cubit.dart';
import '../controllers/search bloc/search_bloc.dart';
import '../models/repository_response_model.dart';
import 'repo_detail_page.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<RepoCubit>(context).loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<RepoCubit>(context).loadPosts();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Repositories"),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: GithubRepoSearch(
                      searchBloc: BlocProvider.of<SearchBloc>(context),
                      order: 'dsce',
                      page: 1,
                      perPage: 200,
                      sort: 'updated',
                    ));
              }),
        ],
        centerTitle: true,
      ),
      body: _postList(),
    );
  }

  Widget _postList() {
    return BlocBuilder<RepoCubit, RepoState>(builder: (context, state) {
      if (state is RepoLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      //List<Item> item = [];
      List<RepositoryResponseModel> items = [];
      bool isLoading = false;

      if (state is RepoLoading) {
        items = state.items;

        isLoading = true;
      } else if (state is RepoLoaded) {
        items = state.items;
      }

      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < items.length)
            return _buildRepo(items[index], context);
          else {
            Timer(Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: items.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildRepo(RepositoryResponseModel items, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RepoDetailPage(items: items);
        }));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(items.name!),
            Image.network(
              items.owner!.avatarUrl!,
              height: 50,
              width: 50,
            ),
            Text(items.owner!.login!),
            Text(
              "${items.id!}. ${items.description!}",
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(items.owner!.login!),
          ],
        ),
      ),
    );
  }
}
