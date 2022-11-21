import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class NowPlayingMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc(this.getNowPlayingMovies) : super(MovieEmpty()) {
    on<OnNowPlayingMovies>((event, emit) async {
      emit(MovieLoading());

      final getNowPlayingMoviesResult = await getNowPlayingMovies.execute();

      getNowPlayingMoviesResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (moviesData) => emit(
          MovieListHasData(moviesData),
        ),
      );
    });
  }
}

class PopularMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(MovieEmpty()) {
    on<OnPopularMovies>((event, emit) async {
      emit(MovieLoading());

      final getPopularMoviesResult = await getPopularMovies.execute();

      getPopularMoviesResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (moviesData) => emit(
          MovieListHasData(moviesData),
        ),
      );
    });
  }
}

class TopRatedMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies) : super(MovieEmpty()) {
    on<OnTopRatedMovies>((event, emit) async {
      emit(MovieLoading());

      final getTopRatedMoviesResult = await getTopRatedMovies.execute();

      getTopRatedMoviesResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (moviesData) => emit(
          MovieListHasData(moviesData),
        ),
      );
    });
  }
}

class MovieRecommendationsBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsBloc(this.getMovieRecommendations) : super(MovieEmpty()) {
    on<OnMovieRecommendations>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());

      final getMovieRecommendationsResult =
          await getMovieRecommendations.execute(id);

      getMovieRecommendationsResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (movie) => emit(
          MovieListHasData(movie),
        ),
      );
    });
  }
}

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieEmpty()) {
    on<OnMovieDetail>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());

      final getMovieDetailResult = await getMovieDetail.execute(id);

      getMovieDetailResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (movie) => emit(
          MovieDetailHasData(movie),
        ),
      );
    });
  }
}

class MovieWatchlistBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetMovieWatchListStatus getMovieWatchListStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveMovieWatchlist removeMovieWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistBloc(
    this.getMovieWatchListStatus,
    this.getWatchlistMovies,
    this.removeMovieWatchlist,
    this.saveMovieWatchlist,
  ) : super(MovieEmpty()) {
    on<OnMovieWatchlist>((event, emit) async {
      emit(MovieLoading());

      final getMovieWatchlistResult = await getWatchlistMovies.execute();

      getMovieWatchlistResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (data) => emit(
          MovieListHasData(data),
        ),
      );
    });

    on<OnMovieWatchlistStatus>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());

      final getMovieWatchlistStatusResult =
          await getMovieWatchListStatus.execute(id);
      emit(MovieWatchlistStatus(getMovieWatchlistStatusResult));
    });

    on<OnAddMovieWatchlist>((event, emit) async {
      final movie = event.movieDetail;

      emit(MovieLoading());

      final getAddMovieWatchlistResult =
          await saveMovieWatchlist.execute(movie);

      getAddMovieWatchlistResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (successMessage) => emit(
          MovieWatchlistMessage(successMessage),
        ),
      );
    });

    on<OnRemoveMovieWatchlist>((event, emit) async {
      final movie = event.movieDetail;

      emit(MovieLoading());

      final getRemoveMovieWatchlistResult =
          await removeMovieWatchlist.execute(movie);

      getRemoveMovieWatchlistResult.fold(
        (failure) => emit(
          MovieError(failure.message),
        ),
        (successMessage) => emit(
          MovieWatchlistMessage(successMessage),
        ),
      );
    });
  }
}
