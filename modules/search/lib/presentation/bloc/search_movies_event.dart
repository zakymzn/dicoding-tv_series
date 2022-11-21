part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnMoviesQueryChanged extends SearchMoviesEvent {
  final String query;

  OnMoviesQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
