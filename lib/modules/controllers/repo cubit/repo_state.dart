part of 'repo_cubit.dart';

@immutable
abstract class RepoState {}

class RepoInitial extends RepoState {}
class RepoLoaded extends RepoState {
  final List<RepositoryResponseModel> items;
 

  RepoLoaded({required this.items});
}

class RepoLoading extends RepoState {
  final List<RepositoryResponseModel> items;
  
  final bool isFirstFetch;

  RepoLoading(this.items, {this.isFirstFetch=false});
}