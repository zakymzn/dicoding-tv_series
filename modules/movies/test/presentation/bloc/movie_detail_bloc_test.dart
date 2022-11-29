import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'movie_detail_bloc_test.mocks.dart';
import '../../dummy_data/movie_dummy_objects.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(
    () {
      mockGetMovieDetail = MockGetMovieDetail();
      movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
    },
  );

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, MovieEmpty());
  });

  blocTest<MovieDetailBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieDetail.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => const Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnMovieDetail(testMovieDetail.id)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(testMovieDetail.id));
    },
  );

  blocTest<MovieDetailBloc, MovieState>(
    'emits [Loading, Error] when get movie detail is unsuccessful.',
    build: () {
      when(mockGetMovieDetail.execute(testMovieDetail.id)).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnMovieDetail(testMovieDetail.id)),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(testMovieDetail.id));
    },
  );
}
