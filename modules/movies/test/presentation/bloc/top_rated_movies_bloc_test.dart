import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'top_rated_movies_bloc_test.mocks.dart';
import '../../dummy_data/movie_dummy_objects.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(
    () {
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(topRatedMoviesBloc.state, MovieEmpty());
    },
  );

  blocTest<TopRatedMoviesBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMovies()),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMoviesBloc, MovieState>(
    'emits [Loading, Error] when get top rated movies is unsuccessful.',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMovies()),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
