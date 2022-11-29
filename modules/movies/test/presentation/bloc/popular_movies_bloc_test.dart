import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'popular_movies_bloc_test.mocks.dart';
import '../../dummy_data/movie_dummy_objects.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(
    () {
      mockGetPopularMovies = MockGetPopularMovies();
      popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(popularMoviesBloc.state, MovieEmpty());
    },
  );

  blocTest<PopularMoviesBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovies()),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, MovieState>(
    'emits [Loading, Error] when get popular movies is unsuccessful.',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovies()),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
