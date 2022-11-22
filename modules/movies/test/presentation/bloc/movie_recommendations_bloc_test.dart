import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'movie_recommendations_bloc_test.mocks.dart';
import '../../dummy_data/movie_dummy_objects.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(
    () {
      mockGetMovieRecommendations = MockGetMovieRecommendations();
      movieRecommendationsBloc =
          MovieRecommendationsBloc(mockGetMovieRecommendations);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(movieRecommendationsBloc.state, MovieEmpty());
    },
  );

  blocTest<MovieRecommendationsBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieRecommendations.execute(testMovie.id))
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendations(testMovie.id)),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testMovie.id));
    },
  );

  blocTest<MovieRecommendationsBloc, MovieState>(
    'emits [Loading, Error] when get movie recommendations is unsuccessful.',
    build: () {
      when(mockGetMovieRecommendations.execute(testMovie.id)).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendations(testMovie.id)),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testMovie.id));
    },
  );
}
