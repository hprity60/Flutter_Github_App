part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchEventSearch extends SearchEvent {
  final String query;
  final int page;
  final int perPage;

  final String sort;
  final String order;

  const SearchEventSearch(
      this.query, this.order, this.page, this.perPage, this.sort);

  @override
  List<Object> get props => [query, page, perPage, sort, order];
}

class SearchEventLoadMore extends SearchEvent {
  const SearchEventLoadMore();
}
