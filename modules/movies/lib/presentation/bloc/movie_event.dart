part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class OnNowPlayingMovies extends MovieEvent {}

class OnPopularMovies extends MovieEvent {}

class OnTopRatedMovies extends MovieEvent {}

class OnMovieRecommendations extends MovieEvent {
  final int id;
  OnMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class OnMovieDetail extends MovieEvent {
  final int id;
  OnMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnMovieWatchlist extends MovieEvent {}

class OnMovieWatchlistStatus extends MovieEvent {
  final int id;
  OnMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddMovieWatchlist extends MovieEvent {
  final MovieDetail movieDetail;
  OnAddMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveMovieWatchlist extends MovieEvent {
  final MovieDetail movieDetail;
  OnRemoveMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
