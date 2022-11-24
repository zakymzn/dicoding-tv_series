import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/movie_bloc.dart';

class FakeMovieState extends Fake implements MovieState {}

class FakeMovieEvent extends Fake implements MovieEvent {}

class MockNowPlayingMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements NowPlayingMoviesBloc {}

class MockPopularMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMoviesBloc {}

class MockTopRatedMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMoviesBloc {}

class MockMovieDetailBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieDetailBloc {}

class MockMovieRecommendationsBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieRecommendationsBloc {}

class MockMovieWatchlistBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieWatchlistBloc {}
