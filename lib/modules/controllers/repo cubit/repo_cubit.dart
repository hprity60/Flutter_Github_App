import 'package:bloc/bloc.dart';
import 'package:github_search_app/core/data/repositories/repo_list_repositories.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/repository_response_model.dart';
import 'package:github_search_app/modules/model/response_body_model.dart';

part 'repo_state.dart';

class RepoCubit extends Cubit<RepoState> {

  RepoCubit(this.repository) : super(RepoInitial());
  int page = 1;
  final RepoListRepository repository;

  void loadPosts() async {
    if (state is RepoLoading) return;

    final currentState = state;

    var oldPosts = <RepositoryResponseModel>[];

    
    if (currentState is RepoLoaded) {
      oldPosts = currentState.items;
    }

    emit(RepoLoading(oldPosts, isFirstFetch: page == 1, ));

    
    repository.getRepoLists(page).then((newLists) {
      page++;

      final posts = (state as RepoLoading).items;
      posts.addAll(newLists);

      emit(RepoLoaded(items: posts));
    });
  }

  void clearList() {}
}
