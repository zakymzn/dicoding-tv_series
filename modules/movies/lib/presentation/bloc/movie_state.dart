part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasData extends MovieState {
  final List<Movie> result;

  const MovieListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieDetailHasData extends MovieState {
  final MovieDetail result;

  const MovieDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchlistMessage extends MovieState {
  final String message;

  const MovieWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatus extends MovieState {
  final bool status;

  const MovieWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}
