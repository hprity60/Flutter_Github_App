import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search_app/core/data/remote%20datasource/repositories/remote_repositories.dart';
import '../../../../utils/constants.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../models/response_body_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiRepositories _apiRepository;

  List<Item>? items = [];

  SearchBloc({
    required ApiRepositories apiRepositories,
  })  : _apiRepository = apiRepositories,
        super(const SearchStateInitial()) {
    on<SearchEventSearch>(search, transformer: debounce());
  //  on<SearchEventLoadMore>(_loadMore);
  }

  void search(SearchEventSearch event, Emitter<SearchState> emit) async {
    emit(const SearchStateLoading());

    try {
      List<Item>? items = await _apiRepository.searchRepos(event.query, event.page, event.perPage, event.sort, event.order);
      emit(SearchStateLoaded(items: items));
    } catch (e) {
      print(e.toString());
      emit(SearchStateError(e.toString(), 404));
    }
  }

  
}

EventTransformer<Event> debounce<Event>() {
  return (events, mapper) => events.debounce(kDuration).switchMap(mapper);
}
